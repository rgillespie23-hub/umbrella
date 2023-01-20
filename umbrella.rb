p "Where are you located?"

# user_location = gets.chomp

user_location = "Chicago"

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{ user_location }&key=#{ENV.fetch("GMAPS_KEY")}"

require("open-uri")

raw_data = URI.open(gmaps_url).read

require "json"

parsed_data = JSON.parse(raw_data)

results_array = parsed_data.fetch("results")

only_result = results_array.at(0)

geo = only_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

darksky_url = "https://api.darksky.net/forecast/#{ENV.fetch("DARK_SKY_KEY")}/#{ latitude },#{ longitude }"

raw_data_2 = URI.open(darksky_url).read

parsed_data_2 = JSON.parse(raw_data_2)

currently_hash = parsed_data_2.fetch("currently")

current_temperature = currently_hash.fetch("temperature").round(1)

minutely_hash = parsed_data_2.fetch("minutely")

hourly_weather = minutely_hash.fetch("summary")

hourly_hash = parsed_data_2.fetch("hourly")

data_array = hourly_hash.fetch("data")

hour_1_hash = data_array[1]

hour_1_percipitation_probability = hour_1_hash.fetch("precipProbability")
