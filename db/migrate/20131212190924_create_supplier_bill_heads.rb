class CreateSupplierBillHeads < ActiveRecord::Migration
  def change
    create_table :supplier_bill_heads do |t|
      t.date :date
      t.string :number
      t.string :type
      t.float :total
      t.integer :supplier_id
      t.integer :payment_id

      t.timestamps
    end
  end
end
