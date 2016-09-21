class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user=User.new
  end

  def create
    @user = User.new(user_params)
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
    @user = User.find_by(name: params[:name])
    @posts = @user.posts.paginate(page: params[:page])
  end
  
  def edit
    @user = User.find_by(name: params[:name])
  end
  
  def update
    @user = User.find_by(name: params[:name])
    if @user.update_attributes(user_params)
       @user.reload
      #redirect_to user_url(@user)
      flash[:success]="Your information have been updated" 
      redirect_to user_url(@user)
    else
      render 'user_edit'
    end
  end
  
  private
  #Required to avoid mass assignment
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

    # Confirms the correct user.
  def correct_user
    @user = User.find_by(name: params[:name])
    unless @user == current_user
      redirect_to user_url(@user)
    end
  end
end
