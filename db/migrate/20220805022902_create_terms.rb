class CreateTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :terms do |t|
      t.integer :sm_code
      t.date :start_of_term
      t.date :end_of_term
      t.integer :appointment_status
      t.belongs_to :termable, polymorphic: true, index: true
      t.belongs_to :position, foreign_key: true
      t.belongs_to :political_party, foreign_key: true

      t.timestamps
    end
  end
end
