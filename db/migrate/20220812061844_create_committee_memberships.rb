class CreateCommitteeMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :committee_memberships do |t|
      t.string :name
      t.date :start_of_term
      t.date :end_of_term
      t.boolean :active
      t.belongs_to :committee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
