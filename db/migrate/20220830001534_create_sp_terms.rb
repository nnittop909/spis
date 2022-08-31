class CreateSpTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :sp_terms do |t|
      t.integer :ordinal_number
      t.date :start_of_term
      t.date :end_of_term
      t.belongs_to :office, foreign_key: true

      t.timestamps
    end
  end
end
