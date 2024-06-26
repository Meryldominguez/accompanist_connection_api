# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles
  has_many :rollout_overrides, as: :resource

  validates :name, presence: true, uniqueness: true
  scope :admin, -> { where(name: 'admin').first }
end
