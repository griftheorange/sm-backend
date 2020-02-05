class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :address
  has_many :bookmarks
end
