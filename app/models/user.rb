# frozen_string_literal: true

class User < ApplicationRecord
  include Rememberable
  include Confirmable

  MAILER_FROM_EMAIL = 'no-reply@example.com'

  has_secure_password

  has_many :profiles, dependent: :destroy
  has_many :instruments, through: :profiles
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :rollout_overrides, as: :resource

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, length: { minimum: 4, maximum: 50 }, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Email invalid' }
  before_save { email.downcase! }

  scope :admins, -> { Role.admin.users }

  def full_name
    "#{first_name} #{last_name}"
  end

  # def add_instrument

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end

  def add_role(role)
    error_unless_role_exists(role)
    roles << Role.find_by(name: role)
  end

  def remove_role(role)
    error_unless_role_exists(role)
    raise Exceptions::ResourceNotConnectedError unless role?(role)

    roles.delete(Role.find_by(name: role))
  end

  def admin?
    role?(:admin)
  end

  def make_admin
    admin_role = Role.find_by(name: :admin)
    error_unless_role_exists(:admin)
    roles << admin_role
  end

  private

  def error_unless_role_exists(role)
    raise ActiveRecord::RecordNotFound unless Role.find_by(name: role)
  end
end
