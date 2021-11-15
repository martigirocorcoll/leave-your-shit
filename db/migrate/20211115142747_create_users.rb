class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_number
      t.string :email_address
      t.string :seller_type

      t.timestamps
    end
  end
end
