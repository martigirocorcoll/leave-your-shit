class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.boolean :availability
      t.string :location_address
      t.float :price
      t.string :name
      t.text :description
      t.string :property_type

      t.timestamps
    end
  end
end
