class CreateClientCurrentAccounts < ActiveRecord::Migration
  def change
    create_table :client_current_accounts do |t|
      t.integer :client_id
      t.integer :client_bill_head_id

      t.timestamps
    end
  end
end
