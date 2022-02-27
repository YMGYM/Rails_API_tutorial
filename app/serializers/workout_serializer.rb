class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :exercise_id, :user_id, :work_time, :calorie_amount
end
