# https://github.com/whazzmaster/fitgem/wiki/The-OAuth-Process

require 'fitgem'
require 'wunderground'

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

device_id = client.devices.first['id']
alarm_id = client.get_alarms(device_id)['trackerAlarms'].first['alarmId']

# https://github.com/wnadeau/wunderground
wug = Wunderground.new(ENV['WUNDERGROUND_API_KEY'])
astronomy = wug.astronomy_for(ENV['STATE'],ENV['CITY'])
sunrise = astronomy['sun_phase']['sunrise']
sunrise_hour = "%02d" % sunrise['hour']
sunrise_minute = "%02d" % sunrise['minute']
sunrise_time = "#{sunrise_hour}:#{sunrise_minute}"

alarm_opts =  {
    time: sunrise_time,
    label: "Sunrise",
    enabled: true,
    recurring: true,
    weekDays: "MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY",
    snoozeLength: 5,
    snoozeCount: 3
}

client.update_alarm(alarm_id, device_id, alarm_opts)

p client.get_alarms(device_id)
