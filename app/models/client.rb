class Client < ActiveRecord::Base
	validates :name, presence: true
	validates :last_name, presence: true
	validates :cod, presence: true, uniqueness: true

	has_many :client_phone, :dependent => :destroy
	has_many :client_bill_heads
	has_many :client_current_account, :dependent => :destroy
	has_many :client_receipts, :dependent => :destroy

	def as_json(*args)
    	super.tap { |hash| hash["value"] = hash.delete "name" }
	end
end
