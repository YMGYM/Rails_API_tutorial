class UserSerializer < ActiveModel::Serializer
  attributes :id, :email

  has_many :workouts
  belongs_to :tier
end
