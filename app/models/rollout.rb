# frozen_string_literal: true

class Rollout < ApplicationRecord
  before_create :set_offset
  before_validation :uppercase_resource_type

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates_inclusion_of :percent_enabled, in: 0..100
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

  def green_list_includes?(resource)
    green_list.include? resource.id
  end

  def red_list_includes?(resource)
    red_list.include? resource.id
  end

  def add_green_list_resource(resource)
    return false unless resource_matches_type(resource)

    update_attribute(:green_list, green_list.append(resource.id))
  end

  def add_red_list_resource(resource)
    return false unless resource_matches_type(resource)

    update_attribute(:red_list, red_list.append(resource.id))
  end

  def remove_green_list_resource(resource)
    return false unless resource_matches_type(resource)

    update_attribute(:green_list, green_list.filter(resource.id))
  end

  def remove_red_list_resource(resource)
    return false unless resource_matches_type(resource)

    update_attribute(:red_list, red_list.filter(resource.id))
  end

  def percent_enabled=(num)
    update_attribute(:percent_enabled, num)
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
