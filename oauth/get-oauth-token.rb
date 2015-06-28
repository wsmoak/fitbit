# https://github.com/whazzmaster/fitgem/wiki/The-OAuth-Process

require 'fitgem'

consumer_key = ENV['FITBIT_CONSUMER_KEY']
consumer_secret = ENV['FITBIT_CONSUMER_SECRET']

client = Fitgem::Client.new(
  { :consumer_key => consumer_key,
    :consumer_secret => consumer_secret
  }
)

request_token = client.request_token
token = request_token.token
secret = request_token.secret

puts "Go to http://www.fitbit.com/oauth/authorize?oauth_token=#{token} and then enter the verifier code below and hit Enter"
verifier = gets.chomp

access_token = client.authorize(token, secret, {:oauth_verifier => verifier})

puts "Verifier is: "+verifier
puts "Token is:    "+access_token.token
puts "Secret is:   "+access_token.secret
