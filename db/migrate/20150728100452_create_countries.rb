# -*- encoding : utf-8 -*-
class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :iso2
      t.string :short_name
      t.string :long_name
      t.string :iso3
      t.string :numcode
      t.string :un_member
      t.string :calling_code
      t.string :cctld
      t.boolean :active, :default => false

      t.timestamps null: false
    end
  end
end
