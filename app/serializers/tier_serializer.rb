class TierSerializer < ActiveModel::Serializer
  attributes :id, :level_name

  has_many :users
end