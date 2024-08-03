# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  fixtures :users, :game_events

  describe "associations" do
    it { should have_many(:game_events).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "devise configuration" do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
    it { should have_db_column(:jti).of_type(:string) }
    it { should have_db_index(:email).unique(true) }
    it { should have_db_index(:jti).unique(true) }
  end

  describe "#total_games_played" do
    let(:user) { users(:mario) }

    it "returns the number of game events" do
      expect(user.total_games_played).to eq(user.game_events.size)
    end
  end
end
