# frozen_string_literal

require "rails_helper"

RSpec.describe Api::UsersController, type: :controller do
  include Devise::Test::ControllerHelpers
  fixtures :users, :game_events

  let(:user) { users(:mario) }

  before(:each) { sign_in(user) }

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end

    it "returns currents user with stats" do
      get :show
      response_json = JSON.parse(response.body)

      expect(response_json).to have_key("user")
      expect(response_json["user"]).to include({
        "id" => user.id,
        "email" => user.email,
        "member_since" => anything,
        "stats" => {
          "total_games_played" => user.total_games_played
        }
      })
    end
  end
end
