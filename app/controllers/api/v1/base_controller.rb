class Api::V1::BaseController < ApplicationController
  include ActionController::MimeResponds
  protect_from_forgery with: :null_session

  before_action :destroy_session
  
  attr_accessor :current_user
  
  
  protected
  def destroy_session
    request.session_options[:skip] = true
  end
  
  
  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: jsonapi_format(errors).to_json, status: status
  end
  
  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    @user_email = options.blank?? nil : options[:email]
    @user = User.find_by(email: @user_email)

    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      @current_user = @user
    else
      return unauthenticated!
    end
  end
  
  def unauthenticated!
    response.headers['WWW-Authenticate'] = "Token realm=Application"
    render json: { error: 'Bad credentials' }, status: 401
  end
  
  private
  
  def jsonapi_format(errors)
    return errors if errors.is_a? String
    errors_hash = {}
    errors.messages.each do |attribute, error|
      array_hash = []
      error.each do |e|
        array_hash << {attribute: attribute, message: e}
      end
      errors_hash.merge!({ attribute => array_hash })
    end

    return errors_hash
  end
end
