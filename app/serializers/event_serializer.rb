class EventSerializer < ActiveModel::Serializer
  attributes :id, :users, :name, :description
end
