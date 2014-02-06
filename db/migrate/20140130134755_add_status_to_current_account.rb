class AddStatusToCurrentAccount < ActiveRecord::Migration
  def change
  	add_column :client_current_accounts, :status, :string
  end
end
