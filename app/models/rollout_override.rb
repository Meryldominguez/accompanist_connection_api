# frozen_string_literal: true

class RolloutOverride < ApplicationRecord
  belongs_to :rollout, optional: false
  belongs_to :resource, polymorphic: true, optional: false
end
