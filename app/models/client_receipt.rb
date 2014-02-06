class ClientReceipt < ActiveRecord::Base
	belongs_to :client
	belongs_to :client_current_account
	has_one :client_fee, foreign_key: "receipt_id"
end
