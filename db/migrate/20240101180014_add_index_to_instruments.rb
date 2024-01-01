# frozen_string_literal: true

class AddIndexToInstruments < ActiveRecord::Migration[7.1]
  def change
    add_index :instruments, :name
  end
end
