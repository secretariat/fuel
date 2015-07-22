# -*- encoding : utf-8 -*-
class CreateFuels < ActiveRecord::Migration
  def change
    create_table :fuels do |t|
      t.string :name
      
      t.timestamps
    end
  end
end