class CreateClientBillBodyTemps < ActiveRecord::Migration
  def change
    create_table :client_bill_body_temps do |t|
      t.integer :quantity
      t.integer :price
      t.integer :product_id
      t.integer :client_bill_head_id
      t.integer :user_id

      t.timestamps
    end
  end
end
