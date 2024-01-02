# frozen_string_literal: true

class AddIndexToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_index :profiles, %i[user_id instrument_id], unique: true
  end
end
