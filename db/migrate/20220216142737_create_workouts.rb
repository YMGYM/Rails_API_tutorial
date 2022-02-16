class CreateWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :workouts do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :work_time, default: 0
      t.integer :calorie_amount, default: 0

      t.timestamps
    end
  end
end
