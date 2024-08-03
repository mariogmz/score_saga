# frozen_string_literal: true

class GameEventSerializer
  include JSONAPI::Serializer
  attributes :id, :event_type, :occurred_at, :game_id
end
