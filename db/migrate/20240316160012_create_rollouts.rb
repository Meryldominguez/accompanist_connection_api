# frozen_string_literal: true

class CreateRollouts < ActiveRecord::Migration[7.1]
  def change
    cre
    create_table :rollouts do |t|
      t.string :name, index: { unique: true, name: 'unique_name' }
      t.integer :percent_enabled, null: false, default: 0
      t.integer :offset, default: 0
      t.string :resource_type, null: false
      t.timestamps
    end
  end
end
