# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'csv'

# import tiers
tiers = []
CSV.foreach('db/samples/tier_sample.csv', headers: true, header_converters: :symbol) do |row|
  tiers << row.to_h
end
Tier.import tiers

# import exercise
exercises = []
CSV.foreach('db/samples/exercise_sample.csv', headers: true, header_converters: :symbol) do |row|
  exercises << row.to_h
end
Exercise.import exercises
