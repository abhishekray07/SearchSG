require 'rubygems'
require 'nokogiri'
require 'open-uri'

HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}"}

url = "http://www.yelp.com.sg/biz/zzapi-singapore"
doc = Nokogiri::HTML(open(url, HEADERS_HASH))
if doc.at_css(".hours")
	puts doc.at_css(".hours").text
else
	puts "No Hours Mentioned"
end

puts doc.at_css("#bizUrl").text.strip
 doc.css(".photo-box-img").each do |photo|
#   title = item.at_css(".ListItemLink , .highlight").text
#   price = item.at_css(".camelPrice span").text[/\$[0-9\.]+/]
#   puts "#{title} - #{price}"
  	puts photo[:src]
end