p "Where are you located?"

# user_location = gets.chomp

user_location = "Detroit"

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

p latitude
p longitude
