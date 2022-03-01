class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :work_time, :calorie_amount

  belongs_to :exercise
  belongs_to :user
end
