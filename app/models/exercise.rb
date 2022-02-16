class Exercise < ApplicationRecord
  has_many :workouts
  belongs_to :tier, class_name: "tier", foreign_key: "tier_id"

  enum part: { chest:0, arm:1, shoulder:2, abdominal:3, back:4, lower:5} # 순서대로 가슴, 팔, 어깨, 복근, 등, 하체
end
