class Supplier < ActiveRecord::Base
	has_many :salesmen
	has_many :supplier_bill_head

	validates :name, presence: true, uniqueness: true
end
