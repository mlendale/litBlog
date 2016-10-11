class Api::V1::PostsController < Api::V1::BaseController
  include ActionController::MimeResponds
  before_filter :load_post, :only => [:show, :update, :destroy]
  
  #Show one post. For testing but will not be used.
  def show    
    
    #if @post    
     render jsonapi: @post, serializer: Api::V1::PostSerializer
    #else
    #   render jsonapi: "User not found", status: 404
    #end
  end
  
  #Show all posts
  def index    
    posts=Post.all.order(created_at: :desc)
	render jsonapi: posts, each_serializer: Api::V1::PostSerializer, root: 'posts'
  end
 
 # Create post
  def create
    post = current_user.posts.build(post_params)
    respond_to do |format|
      if post.save
        format.jsonapi { render jsonapi: post, status: :created, location: @current_user }
      else
        format.jsonapi { render jsonapi: post.errors, status: :unprocessable_entity }
      end
    end
  end

# Update post
  def update
   
    respond_to do |format|
      if @post.update_attributes(post_params)
        #@post.reload #Is it needed?
        format.jsonapi { render jsonapi: @post, status: :ok, location: @post }
      else
        format.jsonapi { render jsonapi: @post.errors, status: :unprocessable_entity }
      end
    end
  end
 

 
  private
    # Only allow a trusted parameter "white list" through.
  def post_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:content] )
  end

  def load_post
    @post = Post.find_by_id(params[:id])
    head 404 and return unless @post.present?
  end

end
