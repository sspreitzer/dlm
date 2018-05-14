# dlm
Conservative redis based ruby distributed lock manager

# Requirements

This gem requires a running redis server and the redis ruby gem.

# Usage

```shell
gem install dlm
```

or Gemfile

```ruby
source 'https://rubygems.org'

gem 'dlm'
```

# Example

```ruby
require 'dlm'

dlm = DLM.new

dlm.lock('test')
# do work here
dlm.unlock('test')
```

# Copyright

Sascha Spreitzer, (c) 2018, [MIT license](LICENSE)
