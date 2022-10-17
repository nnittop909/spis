class AddAliasNameToPositions < ActiveRecord::Migration[7.0]
  def change
    add_column :positions, :alias_name, :integer
  end
end
