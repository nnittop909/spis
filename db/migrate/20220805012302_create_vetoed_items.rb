class CreateVetoedItems < ActiveRecord::Migration[7.0]
  def change
    create_table :vetoed_items do |t|
      t.string :name
      t.belongs_to :staging, foreign_key: true

      t.timestamps
    end
  end
end
