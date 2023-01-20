class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.belongs_to :attendee, null: false, foreign_key: true
      t.belongs_to :eventable, polymorphic: true
      t.integer :attendee_role

      t.timestamps
    end
  end
end
