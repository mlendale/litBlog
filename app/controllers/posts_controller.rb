class PostsController < ApplicationController
  # Create a post if user is logged-in
  before_action :logged_in_user, only: [:create, :destroy]
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to user_path(@current_user)
    else
      render 'welcome/index'
    end
  end
  
  def destroy
    #
  end
  
  private

    def post_params
      params.require(:post).permit(:content)
    end
end
