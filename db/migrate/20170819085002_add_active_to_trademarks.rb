class AddActiveToTrademarks < ActiveRecord::Migration
  def change
  	add_column :trademarks, :active, :boolean, :default => true
  end
end
