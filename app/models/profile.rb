# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :instrument, optional: false
  has_many :rollouts, as: :resource

  validates_uniqueness_of :user_id, scope: :instrument_id, message: 'Profile already exists for this user and this instrument'
end
