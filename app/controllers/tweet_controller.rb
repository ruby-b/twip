class TweetController < ApplicationController
  def index
    @text = params[:text]
    @users = User.all
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.description
      marker.json({title: user.title})
    end
  end
end
