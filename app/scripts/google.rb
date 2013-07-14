require "net/https"
require "json"
require "uri"

uri = URI.parse("https://maps.googleapis.com/maps/api/place/search/json?location=1.31675,103.8904&radius=5000&name=%22fitness+first%22&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
# uri = URI.parse("https://maps.googleapis.com/maps/api/place/details/json?reference=CnRrAAAAu-ws8DX_v7kAqYCXgefeIwgu1KPPnKbFFw9RVv07Z3DIGXs9ZbqnreX4o2wvOC7S7ByKn75gxHCEbOhxs1RWbN5HPhAVCIJ3h3skayYjRVDh1KGzcJfCCMPYK1ciOuQqCKt3mVv4QOhdgWi6QaNnMRIQQCjAOoeJG2RgPlo1vtrWyhoUOt8k28_qrLFYk9Xpmu_NRV-06k4&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
hash = JSON.parse response.body
# p hash

hash["results"].each do |result|
	puts "#{result["name"]} => #{result["vicinity"]}" 
	if result["opening_hours"]
		puts result["opening_hours"]["open_now"]
	end
end