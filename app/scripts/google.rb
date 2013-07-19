require "net/https"
require "json"
require "uri"
require "Geocoder"

uri = URI.parse("https://maps.googleapis.com/maps/api/place/search/json?location=1.28967,103.85&radius=5000&name=%22fitness+first%22&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
# uri = URI.parse("https://maps.googleapis.com/maps/api/place/details/json?reference=CnRrAAAAu-ws8DX_v7kAqYCXgefeIwgu1KPPnKbFFw9RVv07Z3DIGXs9ZbqnreX4o2wvOC7S7ByKn75gxHCEbOhxs1RWbN5HPhAVCIJ3h3skayYjRVDh1KGzcJfCCMPYK1ciOuQqCKt3mVv4QOhdgWi6QaNnMRIQQCjAOoeJG2RgPlo1vtrWyhoUOt8k28_qrLFYk9Xpmu_NRV-06k4&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
hash = JSON.parse response.body

p Geocoder::Calculations.distance_between([1.28967,103.85], [40.748433,-73.985655])

# p hash["results"]
# p hash["result"]["formatted_address"]
# p hash["result"]["international_phone_number"]
# p hash["result"]["name"]

# p hash["result"]["reviews"][0]
hash["results"].each do |result|
	puts "#{result["name"]} => #{result["vicinity"]} => #{result["reference"]} " 
	puts "Distance"
	p Geocoder::Calculations.distance_between([1.28967,103.85], [result["geometry"]["location"]["lat"],result["geometry"]["location"]["lng"]])

	if result["opening_hours"]
		puts result["opening_hours"]["open_now"]
	end
end

# hash["result"]["reviews"].each do |result|
# 	p result["author_name"]
# end

# p hash["result"]["opening_hours"]["open_now"]