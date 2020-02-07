class CommentSerializer < ActiveModel::Serializer
  attributes :id, :date_posted, :content
  has_one :user
  has_one :commented_quake
end
