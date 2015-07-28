# -*- encoding : utf-8 -*-
class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :lang_id
      t.integer :country_id
      t.integer :region_id

      t.timestamps null: false
    end
  end
end
