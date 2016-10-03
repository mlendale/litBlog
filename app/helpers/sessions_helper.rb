module SessionsHelper
#Allows to use the same methods in multiple controllers
  
  # Store User id in session hash
  def log_in(user)
    session[:user_id]=user.id
  end
  
  def log_out
    session.delete(:user_id)
    @current_user=nil
  end
  
  # Returns current user or nil
  def current_user
    @current_user ||=User.find_by(id: session[:user_id])
  end
  
  # Returns true if user is current user
  def current_user?(user)
    logged_in? ? current_user.id == user.id : nil
  end
  
  # Returns true if the user is logged in
  def logged_in?
    !current_user.nil?
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  
end
