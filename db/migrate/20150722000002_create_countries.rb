# -*- encoding : utf-8 -*-
class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :iso2, :length => 3
      t.string :short_name, :length => 80
      t.string :long_name, :length => 100
      t.string :iso3, :length => 5
      t.string :numcode, :length => 6
      t.string :un_member, :length => 12
      t.string :calling_code, :length => 10
      t.string :cctld, :length => 7

      t.timestamps null: false
    end
  end
end