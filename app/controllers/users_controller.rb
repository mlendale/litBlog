class UsersController < ApplicationController
  def new
    @user=User.new
  end

  def create
    @user = User.new(set_strong_params)
    #Go to User page
    if @user.save
      redirect_to user_url(@user)
    
    #Redirect to the Signup page if attributes are invalid  
    else
      render 'new'
    end
  end

  def show
    @user=User.find(params[:id])
  end
  
  private
  #Required to avoid mass assignment
  def set_strong_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
