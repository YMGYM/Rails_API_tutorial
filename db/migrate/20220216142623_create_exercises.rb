class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :title, null: false
      t.integer :part, null: false
      t.references :tier, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
