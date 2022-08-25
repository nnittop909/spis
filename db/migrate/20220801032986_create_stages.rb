class CreateStages < ActiveRecord::Migration[7.0]
  def change
    create_table :stages do |t|
      t.string :name
      t.string :alias_name
      t.integer :phase

      t.timestamps
    end
  end
end
