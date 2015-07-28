# -*- encoding : utf-8 -*-
class CreateTrademarks < ActiveRecord::Migration
  def change
    create_table :trademarks do |t|
      t.string :name
      t.string :operator_name
      t.string :lang_id

      t.timestamps null: false
    end
  end
end
