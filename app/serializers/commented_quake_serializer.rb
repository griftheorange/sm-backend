class CommentedQuakeSerializer < ActiveModel::Serializer
  attributes :id, :quake_db_id
  has_many :comments
end
