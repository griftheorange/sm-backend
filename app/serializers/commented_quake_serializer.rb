class CommentedQuakeSerializer < ActiveModel::Serializer
  attributes :id, :quake_db_id
end
