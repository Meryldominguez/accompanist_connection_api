# frozen_string_literal: true

class CreateRolloutOverrides < ActiveRecord::Migration[7.1]
  def change
    create_table :rollout_overrides do |t|
      t.references :resource, polymorphic: true, null: false
      t.references :rollout, foreign_key: true
      t.boolean :allow, null: false

      t.timestamps
    end
  end
end
