require 'jumpstart_auth'
require 'bitly'
require 'klout'


class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing..."
    @client = JumpstartAuth.twitter
    Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'
  end
  
  def tweet(message)
    
    #If the message to tweet is less than or equal to 140 characters long, tweet it.
    if message.length > 140
       @client.update(message)
    #Otherwise, print out a warning message and do not post the tweet.\
     else
       @warning = "Your tweet is too long(over 140 characters), please try again."
     end
  end
 
  def dm(target, message)
    screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
    if screen_names.include?(target)
      puts "Trying to send #{target} this direct message:"
      puts message
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "Error: You can only DM people following you."
    end
  end
  
  def followers_list  
    # Create a blank array named screen_names
    screen_names = []
    # On the @client call the followers method iterate through each of them performing the instructi       on screen_names << @client.user(follower).screen_name
    @client.followers.each do |follower| 
      screen_names << @client.user(follower).screen_name
    end
    # Return the array screen_names
    screen_names
  end
  
  def spam_my_followers(message)
#     Get the list of your followers from the followers_list method
    spam_list = followers_list
#     Iterate through each of those followers and use your dm method to send them the message
    spam_list.each do |follower|
      dm(follower, message)
    end
  end
  
  def everyones_last_tweet
    friends = @client.friends
    friends.sort_by { |friend| friend.screen_name.downcase }
    friends.each do |friend|
      # find the message created time
      timestamp = friend.status.created_at
      # find each friend's last message
      last_message = friend.status.text
      # print each friend's screen_name
      puts "#{friend.screen_name} said this on #{timestamp.strftime("%A, %b %d")}..."
      # print each friend's last message
      puts "#{friend.last_message}"
      puts "" # Just print a blank line to separate people
    end
  end

  def shorten(original_url)
     # Shortening Code
    Bitly.use_api_version_3
    bitly = Bitly.new("hungryacademy", "R_430e9f62250186d2612cca76eee2dbc6")
    puts "Shortening this URL: #{original_url}"
    # Make sure that your method ends with a return statement so it sends the shortened URL that to th     e method that called it.
    return bitly.shorten(original_url).short_url
  end

  def klout_score
    friends = @client.friends.collect{|f| f.screen_name}
    friends.each do |friend|
      # print your friend's screen_name
      puts "#{friend}"
      # print your friends's Klout score
      identity = Klout::Identity.find_by_screen_name(friend)
      user = Klout::User.new(identity.id)
      puts "#{user.score.score}"
      puts "" # Print a blank line to separate each friend
    end
  end

  def run
    command = ""
    while command != "q"
      printf "Enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        when 'dm' then dm(parts[1], parts[2..-1].join(" "))
        when 'spam' then spam_my_followers(parts[1..-1].join(" "))
        when 'elt' then everyones_last_tweet
        when 's' then shorten(parts[1..-1].join(" "))
        when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
        else
          puts "Sorry, I don't know how to #{command}."
      end
    end
  end
 
end

blogger = MicroBlogger.new
blogger.run
blogger.klout_score