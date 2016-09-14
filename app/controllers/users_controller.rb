class UsersController < ApplicationController
  def new
    @user=User.new
  end

  def create
    @user = User.new(set_strong_params)
    #Go to User page
    if @user.save
      # Use the log_in method from SessionHelper
      log_in @user
      redirect_to user_url(@user)
    
    #Redirect to the Signup page if attributes are invalid  
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
  
  private
  #Required to avoid mass assignment
  def set_strong_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
