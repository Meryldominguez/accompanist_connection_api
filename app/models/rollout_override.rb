# frozen_string_literal: true

class RolloutOverride < ApplicationRecord
  belongs_to :rollout, optional: false
  belongs_to :resource, polymorphic: true, optional: false
  before_save :resource_type_must_equal_rollout_type

  validates :resource_id, presence: true, uniqueness: { scope: %i[resource_type rollout_id] }
  validates :allow, inclusion: { in: [true, false] }
  validate :validate_resource_type, on: :update, if: :resource_changed?

  private

  def resource_type_must_equal_rollout_type
    raise "Resource type, #{resource.class.name}, must equal the Rollout resource, #{rollout.resource_type}" unless rollout.resource_matches_rollout_type(resource)
  end

  def validate_resource_type
    return unless resource.class.name != rollout.resource_type

    errors.add(:resource_type, "Must match resource_type of rollout, #{rollout.resource_type}")
  end
end
