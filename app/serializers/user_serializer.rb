# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email
  attribute :member_since, &:created_at
  attribute :total_games_played, if: Proc.new { |_record, params| params && params[:include_total_games] == true }
end
