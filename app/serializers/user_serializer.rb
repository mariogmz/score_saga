# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email
  attribute :member_since, &:created_at
  attribute :stats, if: Proc.new { |record, params| params[:include_stats] == true } do |object|
    {
      total_games_played: object.total_games_played
    }
  end
end
