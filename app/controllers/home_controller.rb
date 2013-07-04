class HomeController < ApplicationController

	require 'rubygems'
	require 'oauth'
	require 'json'
	require 'net/http'
	require 'uri'

	def index

	end

	def search
		@search = params[:search]
		@search_return = google_search(params[:search])
	end

	def show
		@id = params[:id]
		@search = params[:search]
		@search_return = listing_details(@id)
	end

	def search_listing (query, results=10)	
		consumer_key = 'M7hseeLGGd0tPL3cIzY4IA'
		consumer_secret = 'i2jGuWzfqJfWoRCaHotL8uZIAp0'
		token = 'o8UyyEXehc8bmy3a1SQ112XQcgcqnIPR'
		token_secret = 'cqpllzkp-6HOC9p1V0JLOFQY5LU'

		api_host = 'api.yelp.com'

		consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
		access_token = OAuth::AccessToken.new(consumer, token, token_secret)

		path = "/v2/search?term=#{URI.encode(query)}&location=singapore&limit=#{results}"

		# path = "/v2/search?term=hospital&location=singapore&limit=10"

		hash = JSON.parse access_token.get(path).body
		return hash
	end

	def listing_details (query)
		consumer_key = 'M7hseeLGGd0tPL3cIzY4IA'
		consumer_secret = 'i2jGuWzfqJfWoRCaHotL8uZIAp0'
		token = 'o8UyyEXehc8bmy3a1SQ112XQcgcqnIPR'
		token_secret = 'cqpllzkp-6HOC9p1V0JLOFQY5LU'

		api_host = 'api.yelp.com'

		consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
		access_token = OAuth::AccessToken.new(consumer, token, token_secret)

		path = "/v2/business/#{query}"
		hash = JSON.parse access_token.get(path).body
		return hash
	end

	def google_search (query)

		if query.match(" ")
			query = query.gsub!(' ', '%20')
		end
		
		p query
		uri = URI.parse("https://maps.googleapis.com/maps/api/place/search/json?location=1.31675,103.8904&radius=5000&name=%22#{query}%22&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
		
		# uri = URI.parse("https://maps.googleapis.com/maps/api/place/details/json?reference=CpQBgQAAAC9DsmLzesa5EPGeYmuGfhXcYZ3eUtnsJcXUXWlLRWNjZbd-sx-GSb_2KZcYfe8FHtTmUeAxbf4VOpwxkVJjc-xq4PBaUdL0NKwdG9Pt4K339PJoyHDcCW5M3ZOkRcaooo00zJaXsEfbthKCc6UbLKoSaBl3pAEtKWnNN5aEVD_CdoykO4cRinYLIJI-0Dmj0RIQWSpZeG2W77qqDq4B_i0SUxoUaMGymoOBLTiybwUBPHyzHq7olDw&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		hash = JSON.parse response.body
		
		return hash
	end

end
