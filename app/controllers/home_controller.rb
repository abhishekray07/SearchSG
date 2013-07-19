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
		@lat_long = get_lat_long()
		@search_return = google_search(params[:search], @lat_long["latitude"], @lat_long["longitude"])
	end

	def show
		@id = params[:id]
		@search = params[:search]
		@search_return = google_search_details(@id)
	end

	def google_search (query, lat, long)

		if query.match(" ")
			query = query.gsub!(' ', '%20')
		end
		
		uri = URI.parse("https://maps.googleapis.com/maps/api/place/search/json?location=#{lat},#{long}&radius=5000&name=%22#{query}%22&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
		
		p uri
		# uri = URI.parse("https://maps.googleapis.com/maps/api/place/details/json?reference=CpQBgQAAAC9DsmLzesa5EPGeYmuGfhXcYZ3eUtnsJcXUXWlLRWNjZbd-sx-GSb_2KZcYfe8FHtTmUeAxbf4VOpwxkVJjc-xq4PBaUdL0NKwdG9Pt4K339PJoyHDcCW5M3ZOkRcaooo00zJaXsEfbthKCc6UbLKoSaBl3pAEtKWnNN5aEVD_CdoykO4cRinYLIJI-0Dmj0RIQWSpZeG2W77qqDq4B_i0SUxoUaMGymoOBLTiybwUBPHyzHq7olDw&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		hash = JSON.parse response.body
		p hash
		return hash
	end

	def google_search_details (query)

		uri = URI.parse("https://maps.googleapis.com/maps/api/place/details/json?reference=#{query}&sensor=false&key=AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		hash = JSON.parse response.body
		
		return hash["result"]
	end

	def get_lat_long ()
		uri = URI.parse("http://api.ipinfodb.com/v3/ip-city/?key=4956ad7860aecf063c345adc290fd4e1d13af54ad99dcdeb8510b5bf08fc2524&format=json")
		http = Net::HTTP.new(uri.host, uri.port)

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		hash = JSON.parse response.body
		p hash
		return hash
	end

end
