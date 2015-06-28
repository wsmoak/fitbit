# https://github.com/whazzmaster/fitgem/wiki/The-OAuth-Process

require 'fitgem'

consumer_key = ENV['FITBIT_CONSUMER_KEY']
consumer_secret = ENV['FITBIT_CONSUMER_SECRET']
token = ENV['FITBIT_TOKEN']
secret = ENV['FITBIT_SECRET']
user_id = ENV['FITBIT_USER_ID']

client = Fitgem::Client.new(
  { :consumer_key => consumer_key,
    :consumer_secret => consumer_secret,
    :token => token,
    :secret => secret,
    :user_id => user_id
  }
)

access_token = client.reconnect(token, secret)

p client.user_info
