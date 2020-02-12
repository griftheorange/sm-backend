class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commented_quake

  validates :date_posted, presence: true
  validates :content, presence: true
  validates :quake_name, presence: true
  validates :quake_mag, presence: true

  def comment_user
    return self.user.username
  end

  def comment_quake
    return self.commented_quake.quake_db_id
  end

  def user_img_URL
    self.user.image_url
  end
end
