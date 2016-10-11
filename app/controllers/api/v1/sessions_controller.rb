class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      self.current_user = user
      render jsonapi: user, status: :ok, serializer: Api::V1::SessionSerializer
    else
      render jsonapi: "User not authorized #{params[:email].nil?.to_s}", status: 401
    end
  end

end
