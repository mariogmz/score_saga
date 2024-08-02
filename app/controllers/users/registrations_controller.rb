# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  private
    def respond_with(resource, _opts = {})
      if resource.persisted?
        render json: UserSerializer.new(resource).serializable_hash, status: :created
      else
        render json: {
          errors: resource.errors.full_messages
        }, status: :unprocessable_entity
      end
    end
end
