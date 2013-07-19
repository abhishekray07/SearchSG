require "net/https"
require "json"
require "uri"

# uri = URI.parse("https://maps.googleapis.com/maps/api/place/search/json?location=1.31675,103.8904&radius=5000&name=%22fitness+first%22&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
uri = URI.parse("http://api.ipinfodb.com/v3/ip-city/?key=4956ad7860aecf063c345adc290fd4e1d13af54ad99dcdeb8510b5bf08fc2524&ip=220.255.1.30&format=json")
http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
hash = JSON.parse response.body

p hash
p hash["latitude"]
p hash["longitude"]