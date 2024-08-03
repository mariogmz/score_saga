# frozen_string_literal: true

class GameEvent < ApplicationRecord
  TYPES = %w[COMPLETED].freeze

  validates_presence_of :event_type, :occurred_at, :game_id, :user_id
  validates_inclusion_of :event_type, in: TYPES

  belongs_to :user
end
