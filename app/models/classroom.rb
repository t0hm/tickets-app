class Classroom < ApplicationRecord
    enum city: [:ecully_a, :ecully_b, :paris, :st_etienne]

    has_many :tickets
    has_many :users
end
