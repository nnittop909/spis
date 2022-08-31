class CreateSpSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sp_sessions do |t|
      t.integer :event_number
      t.string :title
      t.text :description
      t.date :date
      t.integer :event_type
      t.string :start_time
      t.string :end_time
      t.string :agenda
      t.text :remarks
      t.integer :status

      t.timestamps
    end
  end
end
