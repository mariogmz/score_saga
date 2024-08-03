# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::GameEventsController, type: :controller do
  include Devise::Test::ControllerHelpers
  fixtures :users, :game_events

  let(:user) { users(:mario) }
  let(:user_game_events) { user.game_events }

  describe "GET #index" do
    context "when user is authenticated" do
      before(:each) { sign_in(user) }

      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end

      it "returns a list of game events for the current user" do
        get :index
        json_response = JSON.parse(response.body)
        expect(json_response["data"].size).to eq(user_game_events.size)
        expect(json_response["data"].map { |ge| ge["id"] }).to eq(user_game_events.map(&:id).map(&:to_s))
      end
    end

    context "when user is not authenticated" do
      it "returns an unauthorized response" do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST #create" do
    let(:game_event_params) do
      {
        "game_event" => {
          "type" => "COMPLETED",
          "occurred_at" => "2024-08-01T00:00:00Z",
          "game_id" => 1
        }
      }
    end

    context "when user is authenticated" do
      before(:each) { sign_in(user) }

      it "returns a success response" do
        post(:create, params: game_event_params)
        expect(response).to have_http_status(:created)
      end

      it "creates a new game event for the current user" do
        expect do
          post(:create, params: game_event_params)
        end.to change(user.game_events, :count).by(1)
        expect(user.game_events.last.game_id).to eq(game_event_params["game_event"]["game_id"])
      end
    end

    context "when user is not authenticated" do
      it "returns an unauthorized response" do
        post(:create, params: game_event_params)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
