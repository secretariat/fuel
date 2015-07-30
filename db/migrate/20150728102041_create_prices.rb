# -*- encoding : utf-8 -*-
class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :country_id
      t.integer :region_id
      t.integer :city_id
      t.integer :trademark_id
      t.integer :fuel_type_id
      t.float :cost, :precision=> 3, :default=>0

      t.timestamps null: false
    end
  end
end
