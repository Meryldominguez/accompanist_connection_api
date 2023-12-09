class Instrument < ApplicationRecord
    has_many :profiles, dependent: :destroy
end
