class ClientBillBodyTemp < ActiveRecord::Base
	validates :product_id, presence: true
	validates :price, presence: true
	validates :quantity, presence: true
end