# frozen_string_literal: true

require "rails_helper"

RSpec.describe GameEventSerializer, type: :serializer do
  fixtures :users, :game_events

  let(:game_event) { game_events(:game_event_1) }
  let(:serializer) { described_class.new(game_event) }
  let(:serialization) { serializer.serializable_hash }

  it "includes the correct attributes" do
    expect(serialization[:data][:attributes].keys).to contain_exactly(:id, :event_type, :occurred_at, :game_id, :user)
  end

  it "includes the correct values" do
    expect(serialization[:data][:attributes][:id]).to eq(game_event.id)
    expect(serialization[:data][:attributes][:event_type]).to eq(game_event.event_type)
    expect(serialization[:data][:attributes][:occurred_at]).to eq(game_event.occurred_at)
    expect(serialization[:data][:attributes][:game_id]).to eq(game_event.game_id)
    expect(serialization[:data][:attributes][:user]).to eq(game_event.user)
  end
end
