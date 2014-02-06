class CreateClientBillBodies < ActiveRecord::Migration
  def change
    create_table :client_bill_bodies do |t|
      t.integer :quantity
      t.integer :price
      t.integer :product_id
      t.integer :client_bill_head_id

      t.timestamps
    end
  end
end
