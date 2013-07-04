require "net/https"
require "json"
require "uri"

uri = URI.parse("https://maps.googleapis.com/maps/api/place/search/json?location=1.31675,103.8904&radius=5000&name=%22restaurant%22&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
# uri = URI.parse("https://maps.googleapis.com/maps/api/place/details/json?reference=CoQBeAAAANOfGqZ_1ijEG9XQuDBYAf3syuSBr9zDlxyupsvJjNA8w6eSArZlt-d-bRw16r3ElboDaT0NgI-88-JPnmUrxzZZe7ITXiq_gncZQWv9HDCagmZPZvd0sT-U3tM1OcrNv5-UqmYZadsiIsmxg2-FT4ioybXPgrGwDn-nwY87ZhUTEhCvA8RksYTnEzouoJIFT43QGhTRocHvkbLBXdrS5C-0UAuOYObZgA&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
hash = JSON.parse response.body
p hash

# hash["results"].each do |result|
	# puts "#{result["name"]} => #{result["vicinity"]}" 
# end