# frozen_string_literal: true

class CreateGameEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :game_events do |t|
      t.string :event_type, null: false
      t.timestamp :occurred_at, null: false
      t.bigint :game_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :game_events, :game_id
  end
end
