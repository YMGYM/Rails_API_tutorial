class CreateTiers < ActiveRecord::Migration[6.0]
  def change
    create_table :tiers do |t|
      t.string :level_name, null: false
      t.integer :calorie_amount, null: false
      t.timestamps
    end
  end
end
