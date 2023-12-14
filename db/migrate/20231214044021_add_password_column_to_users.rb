# frozen_string_literal: true

class AddPasswordColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digest, :string, null: false
  end
end
