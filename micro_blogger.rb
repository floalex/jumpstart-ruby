require 'jumpstart_auth'

class Microblogger
  attr_reader :client
  
  def initialize
    puts "Initializing MicroBlogger!"
    @client = JumpstartAuth.twitter
  end
end