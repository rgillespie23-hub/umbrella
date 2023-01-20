p "Where are you located?"

user_location = gets.chomp

p "Checking the weather in " + user_location.capitalize + "..."

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

p "Your coordinates are " + latitude.to_s + ", " + longitude.to_s + "."

darksky_url = "https://api.darksky.net/forecast/#{ENV.fetch("DARK_SKY_KEY")}/#{ latitude },#{ longitude }"

raw_data_2 = URI.open(darksky_url).read

parsed_data_2 = JSON.parse(raw_data_2)

currently_hash = parsed_data_2.fetch("currently")

current_temperature = currently_hash.fetch("temperature").round(1)

p "It is currently " + current_temperature.to_s + "°F."

minutely_hash = parsed_data_2.fetch("minutely")

hourly_weather = minutely_hash.fetch("summary")

p "Next hour: " + hourly_weather

hourly_hash = parsed_data_2.fetch("hourly")

data_array = hourly_hash.fetch("data")

number_of_hours_of_rain = 0.0

13.times do |index|
  hour_hash = data_array[index]
  hour_hash_percipitation_probability = hour_hash.fetch("precipProbability")
  if hour_hash_percipitation_probability >= 0.1
    number_of_hours_of_rain = number_of_hours_of_rain + 1
    p "The percipitation probability is " + hour_hash_percipitation_probability.to_s + " " + index.to_s + " hours from now."
  end
end

if number_of_hours_of_rain > 0.0
  p "You might want to carry an umbrella!"
end
