class AddTrademarkIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :trademark_id, :integer
    add_column :locations, :lat, :decimal, :precision=> 8, :scale => 6
    add_column :locations, :long, :decimal, :precision=> 8, :scale => 6
  end
end
