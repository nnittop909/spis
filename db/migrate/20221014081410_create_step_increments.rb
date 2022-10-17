class CreateStepIncrements < ActiveRecord::Migration[7.0]
  def change
    create_table :step_increments do |t|
      t.date :dated_at
      t.date :effectivity_date
      t.decimal :salary_prior_to_adjustment, precision: 8, scale: 2
      t.decimal :salary_adjustment, precision: 8, scale: 2
      t.decimal :adjusted_salary, precision: 8, scale: 2
      t.belongs_to :member, null: false, foreign_key: true
      t.belongs_to :term, null: false, foreign_key: true

      t.timestamps
    end
  end
end
