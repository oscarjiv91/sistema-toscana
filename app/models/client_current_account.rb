class ClientCurrentAccount < ActiveRecord::Base
	belongs_to :client
	belongs_to :client_bill_head
	has_many :client_fees, :dependent => :delete_all
	has_many :client_receipt, :dependent => :delete_all # cambiado de "has_one" a "has_many"

	validates :client_id, presence: true
	validates :client_bill_head_id, presence: true
end
