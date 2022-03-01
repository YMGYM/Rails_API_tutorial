class TierSerializer < ActiveModel::Serializer
  # TODO : API::TierSerializer
  attributes :id, :level_name

  has_many :users
end