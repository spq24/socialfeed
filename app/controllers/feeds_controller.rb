class FeedsController < ApplicationController
	


	def index
		@twitter = Twitter::REST::Client.new do |config|
		  config.consumer_key        = "RrbWaUSooiqroLB3FXKQ1s8Et"
		  config.consumer_secret     = "j4QY89XrXaeGNiKj3q0r3PxZdRKbADEZHQzXfCpqn0ZGBTTtZk"
		  config.access_token        = "277562395-W9mCZHviUhRILUN8cQQ9DiThIkd5uK1SbIMny9Xe"
		  config.access_token_secret = "qZ3FUtxXnPCzebY0ZKYdlOVzd63tBicTUH0rsb49XwGRS"
		end
	end



end
