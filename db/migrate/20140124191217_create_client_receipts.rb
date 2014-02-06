class CreateClientReceipts < ActiveRecord::Migration
  def change
    create_table :client_receipts do |t|
      t.integer :ammount
      t.integer :client_id
      t.integer :number
      t.integer :client_current_account_id
      t.string :description
      t.date :date
      t.integer :first_payment

      t.timestamps
    end
  end
end
