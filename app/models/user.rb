class User < ApplicationRecord
    has_secure_password

    has_many :bookmarks, dependent: :destroy
    has_many :comments, dependent: :destroy

    validates :username, presence: true
    validates :password, presence: true
    validates :username, uniqueness: true
end
