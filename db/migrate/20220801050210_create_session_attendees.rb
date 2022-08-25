class CreateSessionAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :session_attendees do |t|
      t.string :name
      t.integer :author_type
      t.belongs_to :sp_session, foreign_key: true

      t.timestamps
    end
  end
end
