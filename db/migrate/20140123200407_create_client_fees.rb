class CreateClientFees < ActiveRecord::Migration
  def change
    create_table :client_fees do |t|
      t.integer :ammount
      t.date :expiration_date
      t.date :payment_date
      t.integer :client_current_account_id
      t.integer :receipt_id

      t.timestamps
    end
  end
end
