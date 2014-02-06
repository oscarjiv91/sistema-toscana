class SupplierBillBody < ActiveRecord::Base
	belongs_to :supplier_bill_head
	belongs_to :products

	validates :quantity, presence: true
	validates :price, presence: true
	validates :supplier_bill_head_id, presence: true
	validates :product_id, presence: true

	def self.copyFromTemp(supplier_bill_head_id, ip)
		# it copies the temporary table into the supplier_bill_bodies and the deletes everything whith that IP from the table
		sql = "INSERT INTO supplier_bill_bodies (quantity, price, product_id, supplier_bill_head_id)
				SELECT quantity, price, product_id, #{supplier_bill_head_id}
				FROM bill_body_temps WHERE user_id = '#{ip.to_i}'"
		if ActiveRecord::Base.connection.execute sql
			sql = "DELETE FROM bill_body_temps WHERE user_id = '#{ip.to_i}'"
			ActiveRecord::Base.connection.execute sql
		end
	end

	def self.update_stock(ip)
		@rows = BillBodyTemp.where(user_id: ip.to_i)
		@rows.each do |row|
			sql = "UPDATE product_data SET quantity = quantity + #{row.quantity}, price = #{row.price} WHERE product_data.product_id = #{row.product_id}"
			ActiveRecord::Base.connection.execute sql
		end
	end

	def self.rollback_stock(head_id)
		@rows = SupplierBillBody.where(supplier_bill_head_id: head_id)
		@rows.each do |row|
			sql = "UPDATE product_data SET quantity = quantity - #{row.quantity} WHERE product_data.product_id = #{row.product_id}"
			ActiveRecord::Base.connection.execute sql
		end
	end
end
