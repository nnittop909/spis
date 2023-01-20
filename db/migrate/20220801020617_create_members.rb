class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.integer :code
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :name_suffix
      t.string :full_name
      t.date :birthdate
      t.string :address
      t.string :contact_number
      t.integer :civil_status
      t.string :tin_number
      t.string :gsis_number
      t.text :other_info
      t.belongs_to :civil_service_eligibility, foreign_key: true
      t.belongs_to :educational_attainment, foreign_key: true

      t.timestamps
    end
  end
end
