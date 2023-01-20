class CreateOrdinances < ActiveRecord::Migration[7.0]
  def change
    create_table :ordinances do |t|
      t.integer :code
      t.string :number
      t.string :title
      t.date :date
      t.text :remarks
      t.integer :current_stage
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
