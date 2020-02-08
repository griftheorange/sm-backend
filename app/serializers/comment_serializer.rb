class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :date_posted, :content, :quake_name, :quake_mag, :comment_user, :comment_quake
  has_one :user
  has_one :commented_quake
end
