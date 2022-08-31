class CreateCommitteeReports < ActiveRecord::Migration[7.0]
  def change
    create_table :committee_reports do |t|
      t.string :name
      t.string :report_number
      t.date :date
      t.belongs_to :committee, null: false, foreign_key: true
      t.belongs_to :sp_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
