class SearchTweetsController < ApplicationController

  def search_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "Xr4idXGuvJoAigzwaom3UwR0F"
      config.consumer_secret = "soGuLJGqvKq0qPHBUc3CjkBZSDuaUFsqzaLQZkAfKYPZlna7xj"
      config.access_token = "2931891324-VVmZMdVYIkHmB8G6XI0pdFdIJzdDVhuuUNPMPYs"
      config.oauth_token_secret = "oeElSxhXZNXUFmjY2U8lLvauhuZrmbJpXyZnmPSTT3IpE"
    end
    @tweet = []
    Rails.logger.debug("------------------")
    Rails.logger.debug(params[:text])
    Rails.logger.debug("------------------")
    #5km wo kahen ni siteoku   henkyaku naiyou ni latitude longitude url icon wo tuikasuru
    tweets = client.search("#{params[:text]}",:geocode=>"#{params[:latitude]},#{params[:longitude]},5km",:count=>2)
    tweets.take(5).each do |f|
      tweet_hash ={}
      tweet_hash.store("user_name",f.user.name)
      tweet_hash.store("screen_name",f.user.screen_name)
      tweet_hash.store("icon","#{f.user.profile_image_url.scheme}://#{f.user.profile_image_url.host}#{f.user.profile_image_url.path}")
      tweet_hash.store("text",f.text)
      tweet_hash.store("latitude",f.geo.lat)
      tweet_hash.store("longitude",f.geo.long)
      tweet_hash.store("url","http://twitter.com/#{f.user.screen_name}/status/#{f.user.status.id}")
      @tweet.push(tweet_hash)
    end
    render :json => @tweet
  end

end
