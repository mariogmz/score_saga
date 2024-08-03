# frozen_string_literal: true

class Api::GameEventsController < Api::BaseController
  def index
    render json: GameEventSerializer.new(current_user.game_events).serializable_hash
  end

  def create
    game_event = current_user.game_events.build(game_event_params)

    if game_event.save
      render json: GameEventSerializer.new(game_event).serializable_hash, status: :created
    else
      render json: { errors: game_event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def game_event_params
      params.require(:game_event).permit(:type, :occurred_at, :game_id).tap do |permitted_params|
        permitted_params[:event_type] = permitted_params.delete(:type)
      end
    end
end
