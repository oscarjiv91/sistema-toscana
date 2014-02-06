class CreateClientBillHeads < ActiveRecord::Migration
  def change
    create_table :client_bill_heads do |t|
      t.date :date
      t.integer :number
      t.string :type
      t.integer :total
      t.float :total_iva
      t.integer :client_id
      t.integer :payment_id

      t.timestamps
    end
  end
end
