class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.integer :event_number
      t.string :title
      t.text :description
      t.date :date
      t.integer :event_type
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
