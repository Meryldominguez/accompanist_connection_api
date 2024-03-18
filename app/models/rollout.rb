# frozen_string_literal: true

class Rollout < ApplicationRecord
  has_many :overrides, class_name: 'RolloutOverride'
  before_validation :uppercase_resource_type

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :percent_enabled, presence: true, inclusion: { in: 0..100 }
  validates :resource_type, presence: true, inclusion: { in: %w[User Role Instrument Profile] }

  def resource_enabled?(resource)
    check_resource_type_mismatch(resource)

    return get_override(resource).allow unless get_override(resource).nil?

    id_enabled?(resource.id)
  end

  def get_override(resource)
    overrides.where(resource_type: resource.class.name, resource_id: resource.id).first
  end

  def add_override(resource, action)
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

  def id_enabled?(num, total: 100)
    if (num + offset) >= 100
      (num + offset) % 100 < percent_enabled
    else
      (((num.to_f / total) + (offset.to_f / 100)) * 100) < percent_enabled
    end
  end

  private

  def set_offset
    self.offset = rand(0..100)
  end

  def uppercase_resource_type
    return if resource_type.nil?

    resource_type.capitalize!
  end

  def check_resource_type_mismatch(resource)
    raise "Resource class, #{resource.class.name} must be same class as Rollout resource_type, #{resource_type}" unless resource_matches_rollout_type(resource)
  end
end
