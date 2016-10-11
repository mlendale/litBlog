class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = User.find_by(email: create_params[:email])
    if user && user.authenticate(create_params[:password])
      self.current_user = user
      render jsonapi: user, status: :ok, serializer: Api::V1::SessionSerializer
    else
      render jsonapi: "User not authorized #{create_params[:email].nil?.to_s}", status: 401
    end
  end

  private
  def create_params
	ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:email, :password] )
#    params.permit(:email, :password)
  end
end
