class Bookmark < ApplicationRecord
    belongs_to :user

    validates :user_id, presence: true
    validates :quake_db_id, presence: true
    validates :place, presence: true
    validates :dateAndTime, presence: true
    validates :mag, presence: true
    validates :lat, presence: true
    validates :long, presence: true
end
