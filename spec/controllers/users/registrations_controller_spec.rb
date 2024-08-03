# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::RegistrationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "create a new user" do
    before(:each) do
      post :create, params:
    end

    context "when both email and password are valid" do
      let(:params) do
        { user: { email: "john@doe.com", password: "test123!" } }
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:created)
      end

      it "returns the user data" do
        response_body = JSON.parse(response.body)
        expect(response_body["data"]["attributes"]).to include(
          "email" => "john@doe.com",
          "created_at" => anything,
        )
      end
    end

    context "when email or password is invalid" do
      let(:params) do
        { user: { email: "this_is_not_an_email", password: "lolz" } }
      end

      it "returns an unprocessable entity response" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the error messages" do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["errors"]).to include("Email is invalid", "Password is too short (minimum is 6 characters)")
      end
    end
  end
end
