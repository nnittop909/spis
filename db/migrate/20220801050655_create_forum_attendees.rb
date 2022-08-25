class CreateForumAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :forum_attendees do |t|
      t.string :name
      t.belongs_to :forum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
