require 'redis'

class DLMLockTaken < StandardError
end

class DLM
  def initialize(redis=Redis.new)
    @redis = redis
  end

  def lock(what, block = false, lockinfo = 1)
    self.wait(what) if block
    ret = @redis.set("dlm_#{what}", lockinfo, :nx => true)
    raise DLMLockTaken, "Lock is already taken for #{what}: dlm_#{what}" unless ret
    ret
  end

  def wait(what)
    while ! @redis.get("dlm_#{what}").nil?
      sleep(0.1)
    end
  end

  def lockinfo(what)
    @redis.get("dlm_#{what}")
  end

  def unlock(what)
    @redis.del("dlm_#{what}")
  end

  def unlockall
    keys = @redis.keys("dlm_*")
    @redis.del(keys) unless keys.empty?
  end

end
