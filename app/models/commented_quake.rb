class CommentedQuake < ApplicationRecord
    validates :quake_db_id, presence: true
    validates :quake_db_id, uniqueness: true

    has_many :comments, dependent: :destroy
end
