class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commented_quake

  validates :date_posted, presence: true
  validates :content, presence: true
  validates :quake_name, presence: true
  validates :quake_mag, presence: true

  #provides comment's user's username for serializer
  def comment_user
    return self.user.username
  end

  #provides comment's quake's db_id for serializer
  def comment_quake
    return self.commented_quake.quake_db_id
  end

  #provides comments's user's profile pic url for serializer
  def user_img_URL
    self.user.image_url
  end
end
