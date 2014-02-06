class CreateSupplierBillBodies < ActiveRecord::Migration
  def change
    create_table :supplier_bill_bodies do |t|
      t.integer :quantity
      t.integer :price
      t.integer :supplier_bill_head_id
      t.integer :product_id

      t.timestamps
    end
  end
end
