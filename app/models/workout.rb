class Workout < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :exercise
end
