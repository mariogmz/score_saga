# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  cache_options store: Rails.cache, namespace: "jsonapi-serializer", expires_in: 1.minute

  attributes :id, :email
  attribute :member_since, &:created_at
  attribute :stats, if: Proc.new { |record, params| params[:include_stats] == true } do |object|
    {
      total_games_played: object.total_games_played
    }
  end
end
