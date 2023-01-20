class CreateLceApprovals < ActiveRecord::Migration[7.0]
  def change
    create_table :lce_approvals do |t|
      t.date :approved_date
      t.date :effectivity_date
      t.belongs_to :staging, foreign_key: true

      t.timestamps
    end
  end
end
