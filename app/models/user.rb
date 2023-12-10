class User < ApplicationRecord
    has_many :profiles, dependent: :destroy
    has_many :instruments, through: :profiles

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, length: {minimum: 4, maximum: 50}, uniqueness: { case_sensitive: false }, format: { with: /\A(.+)@(.+)\z/, message: "Email invalid"  }
end
