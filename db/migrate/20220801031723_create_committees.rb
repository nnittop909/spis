class CreateCommittees < ActiveRecord::Migration[7.0]
  def change
    create_table :committees do |t|
      t.integer :code
      t.string :current_name
      t.date :current_start_of_term
      t.date :current_end_of_term

      t.timestamps
    end
  end
end
