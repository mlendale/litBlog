class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #Allow the helper to be available in the controllers
  include SessionsHelper
  private

    # Redirect if user not logged-in.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
