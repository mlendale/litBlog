class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #Allow the helper to be available in the controllers
  include SessionsHelper
end
