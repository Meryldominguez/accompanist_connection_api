class User < ApplicationRecord
    has_many :profiles, dependent: :destroy
    has_many :instruments, through: :profiles
    has_many :user_roles, dependent: :destroy
    has_many :roles, through: :user_roles

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, length: {minimum: 4, maximum: 50}, uniqueness: { case_sensitive: false }, format: { with: /\A(.+)@(.+)\z/, message: "Email invalid"  }

    def role?(role)
        roles.any? { |r| r.name.underscore.to_sym == role }
    end

    def add_role(role)
        roles << Role.find_by(name: role)
    end

    def remove_role(role)
        roles.delete(Role.find_by(name: role))
    end 

    def admin?
        role?(:admin)
    end

    def make_admin
        admin_role = Role.find_by(name: :admin)
        roles << admin_role
    end
end
