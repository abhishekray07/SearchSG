class HomeController < ApplicationController

	require 'rubygems'
	require 'oauth'
	require 'json'
	require 'net/http'

	def index

	end

	def search
		@search = params[:search]
		@search_return = search_listing(params[:search])
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

end
