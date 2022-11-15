class CreateMinutes < ActiveRecord::Migration[7.0]
  def change
    create_table :minutes do |t|
      t.date :date
      t.string :title
      t.integer :minute_type

      t.timestamps
    end
  end
end
