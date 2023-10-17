class CreateMunicipalOrdinances < ActiveRecord::Migration[7.0]
  def change
    create_table :municipal_ordinances do |t|
      t.string :number
      t.string :year_and_number
      t.string :keyword
      t.integer :year_series
      t.date :date_approved
      t.belongs_to :resolution, foreign_key: true
      t.belongs_to :municipality, foreign_key: true

      t.timestamps
    end
  end
end
