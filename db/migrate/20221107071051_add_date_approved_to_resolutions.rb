class AddDateApprovedToResolutions < ActiveRecord::Migration[7.0]
  def change
    add_column :resolutions, :date_approved, :date
  end
end
