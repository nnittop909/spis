class CreateEventableOrdinances < ActiveRecord::Migration[7.0]
  def change
    create_table :eventable_ordinances do |t|
      t.belongs_to :ordinance, foreign_key: true
      t.belongs_to :eventable, polymorphic: true

      t.timestamps
    end
  end
end
