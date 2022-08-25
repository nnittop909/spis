class CreateSponsorships < ActiveRecord::Migration[7.0]
  def change
    create_table :sponsorships do |t|
      t.belongs_to :sponsor, polymorphic: true
      t.belongs_to :sponsorable, polymorphic: true
      t.integer :role

      t.timestamps
    end
  end
end
