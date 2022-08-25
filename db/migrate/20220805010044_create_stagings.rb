class CreateStagings < ActiveRecord::Migration[7.0]
  def change
    create_table :stagings do |t|
      t.date :date
      t.date :effectivity_date
      t.boolean :current_stage, default: false
      t.belongs_to :stage, foreign_key: true
      t.belongs_to :stageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
