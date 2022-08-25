class CreateCommunityTaxes < ActiveRecord::Migration[7.0]
  def change
    create_table :community_taxes do |t|
      t.string :number
      t.date :date_of_issue
      t.string :place_of_issue
      t.belongs_to :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
