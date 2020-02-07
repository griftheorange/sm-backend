class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :address
  has_many :bookmarks
  has_many :comments
end
