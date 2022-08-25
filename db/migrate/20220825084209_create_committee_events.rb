class CreateCommitteeEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :committee_events do |t|
      t.belongs_to :committee, foreign_key: true
      t.belongs_to :eventable, polymorphic: true

      t.timestamps
    end
  end
end
