class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone_number, :string
    add_column :users, :seller_type, :string
  end
end
