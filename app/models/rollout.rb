# frozen_string_literal: true

class Rollout < ApplicationRecord
  has_many :overrides, class_name: 'RolloutOverride'
  before_validation :uppercase_resource_type

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :percent_enabled, presence: true, inclusion: { in: 0..100 }
  validates :resource_type, presence: true, inclusion: { in: %w[User Role Instrument Profile] }

  def resource_enabled?(resource)
    return false unless resource_matches_type(resource)

    return false if red_list_includes?(resource)
    return true if green_list_includes?(resource)

    total_resources = resource.class.count
    id = resource.id

    if total_resources > 100
      (id + offset) % 100 < percent_enabled
    else
      ((id + offset) % total_resources).to_f / total_resources < percent_enabled / 100
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

  def resource_matches_type(resource)
    resource.class.instance_of? resource_type.constantize
  end
end
