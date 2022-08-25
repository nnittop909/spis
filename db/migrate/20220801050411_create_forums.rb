class CreateForums < ActiveRecord::Migration[7.0]
  def change
    create_table :forums do |t|
      t.date :date
      t.integer :forum_type
      t.string :time_start
      t.string :time_end
      t.string :venue
      t.text :agenda
      t.text :conclusions
      t.string :resource_person

      t.timestamps
    end
  end
end
