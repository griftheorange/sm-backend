class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commented_quake

  validates :date_posted, presence: true
  validates :content, presence: true
end
