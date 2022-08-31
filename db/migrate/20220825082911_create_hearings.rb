class CreateHearings < ActiveRecord::Migration[7.0]
  def change
    create_table :hearings do |t|
      t.integer :event_number
      t.string :title
      t.text :description
      t.integer :event_type
      t.date :date
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
