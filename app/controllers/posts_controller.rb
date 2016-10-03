class PostsController < ApplicationController
  # Create a post if user is logged-in
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to user_path(@current_user)
    else
      render 'welcome/index'
    end
  end
  
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
       @post.reload
      #redirect_to user posts
      flash[:success]="Your post has been updated" 
      redirect_to user_path(@current_user)
    else
      @post = Post.find(params[:id])
      flash.now[:danger]="Invalid content"
      render 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success]="Your post has been deleted" 
    redirect_to user_path(@current_user)
  end
  
  private

    def post_params
      params.require(:post).permit(:content)
    end
    
    def correct_user
    @post = Post.find(params[:id])
    @user = @post.user
    unless @user == current_user
      flash[:danger] = "If you are user #{@user.name} please log in"
      redirect_to login_url
    end
  end
end
