class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :address, :image_url, :radius_concern
  has_many :bookmarks
  has_many :comments
end
