class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.string :address
    	t.integer :region_id
    	t.integer :yandex_id
    	t.string :coordinates
    	t.string :description
      t.timestamps null: false
    end
  end
end
