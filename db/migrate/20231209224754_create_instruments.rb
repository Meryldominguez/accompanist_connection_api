# frozen_string_literal: true

class CreateInstruments < ActiveRecord::Migration[7.1]
  def change
    create_table :instruments do |t|
      t.string :name

      t.timestamps
    end
  end
end
