class FeedsController < ApplicationController
	


	def index
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV["twitter_consumer_key"]
		  config.consumer_secret     = ENV["twitter_consumer_secret"]
		  config.access_token        = ENV["twitter_access_token"]
		  config.access_token_secret = ENV["twitter_access_token_secret"]
		end

		

		def collect_with_max_id(collection=[], max_id=nil, &block)
		  response = yield(max_id)
		  collection += response
		  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
		end

		def client.get_all_tweets(user)
		  collect_with_max_id do |max_id|
		    options = {:count => 200, :include_rts => true}
		    options[:max_id] = max_id unless max_id.nil?
		    user_timeline(user, options)
		  end
		end

		@twitter = client.get_all_tweets(277562395).map { |t| [t.text, t.created_at.strftime("%m/%d/%Y")] }
	end

end
