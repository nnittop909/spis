class CreateSessionCommittees < ActiveRecord::Migration[7.0]
  def change
    create_table :session_committees do |t|
      t.belongs_to :committee, null: false, foreign_key: true
      t.belongs_to :sp_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
