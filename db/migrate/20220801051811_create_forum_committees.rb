class CreateForumCommittees < ActiveRecord::Migration[7.0]
  def change
    create_table :forum_committees do |t|
      t.belongs_to :forum, null: false, foreign_key: true
      t.belongs_to :committee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
