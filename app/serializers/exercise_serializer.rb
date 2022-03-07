class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :title, :part, :content

  belongs_to :tier
end
