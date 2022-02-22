class Tier < ApplicationRecord
  has_many :exercises
  has_many :users
end
