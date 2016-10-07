class Api::V1::UsersController < Api::V1::BaseController
  include ActionController::MimeResponds
  #Show one user. For testing but will not be used.
  def show    
    user = User.find_by(name: params[:id])
    if user    
      render jsonapi: user, serializer: Api::V1::UserSerializer
    else
       render jsonapi: "User not found", status: 404
    end
  end
 
 # Create user
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.jsonapi { render jsonapi: @user, status: 201, location: @user }
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

 
end
