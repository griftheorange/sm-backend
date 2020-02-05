class BookmarkSerializer < ActiveModel::Serializer
  attributes :id, :quake_db_id, :place, :dateTime, :mag, :lat, :long, :user_id
end
