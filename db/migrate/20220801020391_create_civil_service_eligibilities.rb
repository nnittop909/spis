class CreateCivilServiceEligibilities < ActiveRecord::Migration[7.0]
  def change
    create_table :civil_service_eligibilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
