class ClientReceipt < ActiveRecord::Base
	belongs_to :client
	belongs_to :client_current_account
	has_one :client_fee, foreign_key: "receipt_id"

	validates :ammount, presence: true
	validates :number, presence: true
	validates :client_current_account_id, presence: true
	validates :description, presence: true
	validates :date, presence: true
end
