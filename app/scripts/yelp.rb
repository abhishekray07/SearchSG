	require 'rubygems'
	require 'oauth'
	require 'json'
	require 'net/http'


	query = 'indian restaurant'
	results = 10

		consumer_key = 'M7hseeLGGd0tPL3cIzY4IA'
		consumer_secret = 'i2jGuWzfqJfWoRCaHotL8uZIAp0'
		token = 'o8UyyEXehc8bmy3a1SQ112XQcgcqnIPR'
		token_secret = 'cqpllzkp-6HOC9p1V0JLOFQY5LU'

		api_host = 'api.yelp.com'

		consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
		access_token = OAuth::AccessToken.new(consumer, token, token_secret)

		path = "/v2/search?term=#{URI.encode(query)}&location=singapore&limit=#{results}"
		# path = "/v2/business/anjappar-authentic-chenttinaad-restuarant-singapore"

		# path = "/v2/search?term=hospital&location=singapore&limit=10"

		hash = JSON.parse access_token.get(path).body
		p hash #["businesses"][0]
		# [0]["location"]["display_address"]
