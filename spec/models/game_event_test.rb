# frozen_string_literal: true

require "rails_helper"

RSpec.describe GameEvent, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:event_type) }
    it { should validate_presence_of(:occurred_at) }
    it { should validate_presence_of(:game_id) }
    it { should validate_presence_of(:user_id) }

    describe "type" do
      it { should validate_inclusion_of(:event_type).in_array(GameEvent::TYPES) }
    end
  end
end
