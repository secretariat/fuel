# -*- encoding : utf-8 -*-
class CreateFuelTypes < ActiveRecord::Migration
  def change
    create_table :fuel_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
