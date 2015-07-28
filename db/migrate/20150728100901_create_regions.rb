# -*- encoding : utf-8 -*-
class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.integer :lang_id
      t.integer :country_id

      t.timestamps null: false
    end
  end
end
