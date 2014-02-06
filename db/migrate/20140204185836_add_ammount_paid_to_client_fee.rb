class AddAmmountPaidToClientFee < ActiveRecord::Migration
  def change
  	add_column :client_fees, :ammount_paid, :integer
  end
end
