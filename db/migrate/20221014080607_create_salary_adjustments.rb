class CreateSalaryAdjustments < ActiveRecord::Migration[7.0]
  def change
    create_table :salary_adjustments do |t|
      t.date :dated_at
      t.date :effectivity_date
      t.decimal :monthly_salary, precision: 8, scale: 2
      t.decimal :adjustment, precision: 8, scale: 2
      t.decimal :adjusted_salary, precision: 8, scale: 2
      t.belongs_to :member, null: false, foreign_key: true
      t.belongs_to :term, null: false, foreign_key: true

      t.timestamps
    end
  end
end
