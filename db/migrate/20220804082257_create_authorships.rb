class CreateAuthorships < ActiveRecord::Migration[7.0]
  def change
    create_table :authorships do |t|
      t.belongs_to :author, polymorphic: true
      t.belongs_to :authorable, polymorphic: true
      t.integer :role

      t.timestamps
    end
  end
end
