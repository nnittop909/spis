class CreateCommitteeMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :committee_members do |t|
      t.integer :role
      t.belongs_to :committee, foreign_key: true
      t.belongs_to :committee_membership, foreign_key: true
      t.belongs_to :member, foreign_key: true

      t.timestamps
    end
  end
end
