# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :instrument, optional: false
end
