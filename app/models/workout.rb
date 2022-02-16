class Workout < ApplicationRecord
  belongs_to :user, class_name: "user", foreign_key: "user_id"
  belongs_to :exercise, class_name: "exercise", foreign_key: "exercise_id"
end
