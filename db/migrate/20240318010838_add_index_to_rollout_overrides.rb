# frozen_string_literal: true

class AddIndexToRolloutOverrides < ActiveRecord::Migration[7.1]
  def change
    add_index :rollout_overrides, %i[resource_id resource_type rollout_id], unique: true
  end
end
