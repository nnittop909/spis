class AddInterimToTerms < ActiveRecord::Migration[7.0]
  def change
    add_column :terms, :interim, :boolean
  end
end
