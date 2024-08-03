# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserSerializer, type: :serializer do
  fixtures :users, :game_events

  let(:user) { users(:mario) }
  let(:serializer) { UserSerializer.new(user) }

  describe "attributes" do
    it "includes the id attribute" do
    end

    it "includes the email attribute" do
      expect(serializer.serializable_hash[:data][:attributes]).to have_key(:email)
    end

    it "includes the member_since attribute" do
      expect(serializer.serializable_hash[:data][:attributes]).to have_key(:member_since)
    end
  end

  describe "conditional attribute" do
    context "when include_total_games is true" do
      let(:serializer) { UserSerializer.new(user, params: { include_total_games: true }) }

      it "includes the total_games_played attribute" do
        expect(serializer.serializable_hash[:data][:attributes]).to have_key(:total_games_played)
      end
    end

    context "when include_total_games is false" do
      let(:serializer) { UserSerializer.new(user, params: { include_total_games: false }) }

      it "does not include the total_games_played attribute" do
        expect(serializer.serializable_hash[:data][:attributes]).not_to have_key(:total_games_played)
      end
    end

    context "when include_total_games is not provided" do
      it "does not include the total_games_played attribute" do
        expect(serializer.serializable_hash[:data][:attributes]).not_to have_key(:total_games_played)
      end
    end
  end
end
