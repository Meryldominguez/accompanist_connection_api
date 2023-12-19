# frozen_string_literal: true

class AddRememberTokenAndRememberTokenExpiresAtToUserRoles < ActiveRecord::Migration[7.1]
  def change
    add_column :user_roles, :remember_token, :string
    add_column :user_roles, :remember_token_expires_at, :datetime
  end
end
