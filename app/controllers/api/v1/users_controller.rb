class Api::V1::UsersController < Api::V1::BaseController
  include ActionController::MimeResponds
  before_filter :load_user, :only => [:show, :update, :destroy]
  
  def index
	users=User.all.order(created_at: :asc)
	render jsonapi: users, each_serializer: Api::V1::UserSerializer, root: 'users'
  end
  
  #Show one user. For testing but will not be used.
  def show    
    
    #if @user    
     render jsonapi: @user, serializer: Api::V1::UserSerializer
    #else
    #   render jsonapi: "User not found", status: 404
    #end
  end
 
 # Create user
  def create
    user = User.new(user_params)
    respond_to do |format|
      if user.save
        format.jsonapi { render jsonapi: user, status: :created, location: user }
      else
        format.jsonapi { render jsonapi: user.errors, status: :unprocessable_entity }
      end
    end
  end

# Update user
  def update
   
    respond_to do |format|
      if @user.update_attributes(user_params)
        @user.reload #Is it needed?
        format.jsonapi { render jsonapi: @user, status: :ok, location: @user }
      else
        format.jsonapi { render jsonapi: @user.errors, status: :unprocessable_entity }
      end
    end
  end
 

 
  private
    # Only allow a trusted parameter "white list" through.
  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:name, :email, :password, :password_confirmation] )
  end

  def load_user
    @user = User.find_by(name: params[:id])
    head 404 and return unless @user.present?
  end

end
