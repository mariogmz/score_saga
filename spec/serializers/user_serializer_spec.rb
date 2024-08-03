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

  context "when include_stats is true" do
    let(:serializer) { UserSerializer.new(user, params: { include_stats: true }) }

    it "includes the stats with total_games_played" do
      expect(serializer.serializable_hash[:data][:attributes]).to have_key(:stats)
      expect(serializer.serializable_hash[:data][:attributes][:stats]).to have_key(:total_games_played)
    end
  end

  context "when include_stats is false" do
    let(:serializer) { UserSerializer.new(user, params: { include_stats: false }) }

    it "does not include the stats attribute" do
      expect(serializer.serializable_hash[:data][:attributes]).not_to have_key(:stats)
    end
  end

  context "when include_stats is not provided" do
    it "does not include the stats attribute" do
      expect(serializer.serializable_hash[:data][:attributes]).not_to have_key(:stats)
    end
  end
end
