class WelcomeController < ApplicationController
  def index
    @post = current_user.posts.build if logged_in?
  end
end
