begin
  require 'rubygems'
  require 'wirble'

  Wirble.init
  Wirble.colorize
rescue LoadError
  require 'irb/completion'
  IRB.conf[:PROMPT_MODE] = :SIMPLE
end