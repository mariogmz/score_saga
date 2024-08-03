# frozen_string_literal: true

class Api::UsersController < Api::BaseController
  def show
    render json: { user: json_resource }, status: :ok
  end

  private
    def json_resource
      UserSerializer.new(current_user, params: { include_stats: true }).serializable_hash[:data][:attributes]
    end
end
