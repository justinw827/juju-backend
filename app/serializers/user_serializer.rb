class UserSerializer < ActiveModel::Serializer
  attributes :id, :spotify_id, :groups, :events
end
