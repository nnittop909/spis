class CreateConsideredOrdinances < ActiveRecord::Migration[7.0]
  def change
    create_table :considered_ordinances do |t|
      t.belongs_to :ordinance, null: false, foreign_key: true
      t.belongs_to :forum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
