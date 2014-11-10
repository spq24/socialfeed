class FeedsController < ApplicationController
	


	def index
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV["twitter_consumer_key"]
		  config.consumer_secret     = ENV["twitter_consumer_secret"]
		  config.access_token        = ENV["twitter_access_token"]
		  config.access_token_secret = ENV["twitter_access_token_secret"]
		end

		
		#twitter
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

		 #Google_plus
		 	GooglePlus.api_key = 'AIzaSyC-4Vg0e0CkGsS6yvJVCY_k3B2WnuNaQjU'
		 	person = GooglePlus::Person.get(114826107014451422393)
		 	@google = person.list_activities.items

		 #Facebook
		 @graph = Koala::Facebook::API.new("CAAC7XGwq2isBAPtC8eJ2pbhqHJVM7sVszHxsa4qZCkbzMBu7i5MikpavhEaRAkQXfGlKaZBwQdrYpgA6yqZBGQokZA4MZAEr7pRQZCgG8eYkUhK7UVvsdCzXxVcYOyHmgdElALx4aqZCCTauUlrt5iRYTtCNSQA8sqcQTznZBfceXInkfh05aFA5ModtcZBF7u3if2ToyzKsxyiMpMPZARkN8uLabtu8FyNFcZD")
		 feed = @graph.get_connections("me", "feed")
		 @fb = feed.each {|f| f } # it's a subclass of Array
		 @next_feed = feed.next_page
		 next_page_params = feed.next_page_params
		 end

end
