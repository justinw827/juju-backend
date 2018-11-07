class EventSerializer < ActiveModel::Serializer
  attributes :id, :users, :name, :description, :playlist_id
end
