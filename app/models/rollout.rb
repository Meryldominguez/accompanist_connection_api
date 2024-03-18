# frozen_string_literal: true

class Rollout < ApplicationRecord
  has_many :overrides, class_name: 'RolloutOverride'
  before_validation :uppercase_resource_type

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :percent_enabled, presence: true, inclusion: { in: 0..100 }
  validates :resource_type, presence: true, inclusion: { in: %w[User Role Instrument Profile] }

  def resource_enabled?(resource)
    check_resource_type_mismatch(resource)

    return get_override(resource).value unless get_override(resource).nil?

    calculate_enablement(resource)
  end

  def get_override(resource)
    overrides.where(resource_type: resource.class.name, resource_id: resource.id).first
  end

  def add_override(resource, action: true)
    check_resource_type_mismatch(resource)
    RolloutOverride.create!(resource_type: resource.class.name, resource_id: resource.id, rollout_id: id, allow: action)
  end

  def remove_override(resource)
    check_resource_type_mismatch(resource)
    get_override(resource).destroy
  end

  def resource_matches_rollout_type(resource)
    resource.instance_of? resource_type.constantize
  end

  private

  def set_offset
    self.offset = rand(0..100)
  end

  def uppercase_resource_type
    return if resource_type.nil?

    resource_type.capitalize!
  end

  def calculate_enablement(resource)
    total_resources = resource.class.count

    if total_resources > 100
      (resource.id + offset) % 100 < percent_enabled
    else
      ((resource.id + offset) % total_resources).to_f / total_resources < percent_enabled / 100
    end
  end

  def check_resource_type_mismatch(resource)
    raise "Resource class, #{resource.class.name} must be same class as Rollout resource_type, #{resource_type}" unless resource_matches_rollout_type(resource)
  end
end
