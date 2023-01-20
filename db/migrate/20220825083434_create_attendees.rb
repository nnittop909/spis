class CreateAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :attendees do |t|
      t.string :name
      t.integer :sex
      t.string :position

      t.timestamps
    end
  end
end
