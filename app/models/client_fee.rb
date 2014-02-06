class ClientFee < ActiveRecord::Base
	belongs_to :client_current_account
	belongs_to :client_receipt, foreign_key: "receipt_id"
end
