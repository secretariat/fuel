# -*- encoding : utf-8 -*-
class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :country_id
      t.integer :city_id
      t.integer :region_id
      t.integer :fuel_id
      t.integer :station_id
      t.string :price
      
      t.timestamps
    end
  end
end