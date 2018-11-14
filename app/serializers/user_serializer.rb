class UserSerializer < ActiveModel::Serializer
  attributes :id, :spotify_id, :groups, :events, :image_url, :external_url
end
