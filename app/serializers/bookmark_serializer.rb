class BookmarkSerializer < ActiveModel::Serializer
  attributes :id, :quake_db_id, :place, :dateAndTime, :mag, :lat, :long, :user_id
end
