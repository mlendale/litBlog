class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user=User.new
  end

  def create
    user = User.new(user_params)
    #Go to User page
    if user.save
      # Use the log_in method from SessionHelper
      log_in user
      flash[:success]="Welcome"
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
      #I may need some explanations here
      @user = User.find_by(name: params[:name])
      flash.now[:danger]="Invalid name, email and/or password"
      render 'edit'
    end
  end
  
  private
  #Required to avoid mass assignment
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  

 def correct_user
    @user = User.find_by(name: params[:name])
    unless @user == current_user
      flash[:danger] = "If you are user #{@user.name} please log in"
      redirect_to login_url
    end
  end
end
