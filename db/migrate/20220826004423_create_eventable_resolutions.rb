class CreateEventableResolutions < ActiveRecord::Migration[7.0]
  def change
    create_table :eventable_resolutions do |t|
      t.belongs_to :resolution, foreign_key: true
      t.belongs_to :eventable, polymorphic: true

      t.timestamps
    end
  end
end
