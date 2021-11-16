class Pricetypechangetointeger < ActiveRecord::Migration[6.0]
  def change
    change_column :locations, :price, :integer
  end
end
