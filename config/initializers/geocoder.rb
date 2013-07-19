# config/initializers/geocoder.rb
Geocoder.configure(

  # geocoding service (see below for supported options):
  :lookup => :google_premier,

  # to use an API key:
  :api_key => "AIzaSyCoVITdjn-uJNxBr3qVGyQ69qbXAbbMaXQ",

  # geocoding service request timeout, in seconds (default 3):
  :timeout => 5,

  # set default units to kilometers:
  :units => :km,

)