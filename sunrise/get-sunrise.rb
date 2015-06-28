# https://github.com/wnadeau/wunderground

require 'wunderground'

wug = Wunderground.new(ENV['WUNDERGROUND_API_KEY'])

sunrise = wug.astronomy_for("GA","Atlanta")['sun_phase']['sunrise']

p sunrise['hour']
p sunrise['minute']
