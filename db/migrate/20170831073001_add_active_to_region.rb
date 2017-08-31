class AddActiveToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :active, :boolean, :default => true
  end
end
