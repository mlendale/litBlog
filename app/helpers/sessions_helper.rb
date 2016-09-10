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
  
  # Returns current user id or nil
  def current_user
    @current_user ||=User.find_by(id: session[:user_id])
  end
  
  # Return true if the user is logged in
  def logged_in?
    !current_user.nil?
  end

end
