# frozen_string_literal: true

class Instrument < ApplicationRecord
  has_many :profiles, dependent: :destroy
  has_many :users, through: :profiles
  has_many :rollouts, as: :resource

  # add_user

  validates :name, presence: true, uniqueness: true
end
