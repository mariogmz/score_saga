# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  private
    def respond_with(resource, _opts = {})
      render json: {
        data: {
          token: request.env["warden-jwt_auth.token"],
          user: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
        }
      }
    end

    def respond_to_on_destroy
      return render json: {
        errors: ["Not logged in"],
      }, status: :unauthorized unless request.headers["Authorization"].present?

      current_user = User.find_by(jti: jwt_payload["jti"])

      if current_user
        head :ok
      else
        head :unauthorized
      end
    end

    def jwt_payload
      JWT.decode(request.headers["Authorization"].split.last, Rails.application.credentials.devise_jwt_secret_key!).first
    rescue JWT::DecodeError
      { "jti" => nil }
    end
end
