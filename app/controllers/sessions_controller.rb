class SessionsController < ApplicationController
  def new
  end
  
  def create
    # Fetch user in the database
    user=User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    # Set session[user_id] to user.id
    log_in user
    redirect_to user
    # Notify successful login 
    flash[:success]="Welcome"
    
    else
      # Notify unsuccessful login and rerender the login page
      flash.now[:danger]="Invalid email and/or password"
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end
