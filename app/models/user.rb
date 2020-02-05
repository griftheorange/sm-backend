class User < ApplicationRecord
    has_secure_password

    has_many :bookmarks

    validates :username, presence: true
    validates :password, presence: true
    validates :username, uniqueness: true
end
