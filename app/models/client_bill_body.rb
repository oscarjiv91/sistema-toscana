class ClientBillBody < ActiveRecord::Base
	belongs_to :client_bill_head
	belongs_to :products

	validates :quantity, presence: true
	validates :price, presence: true
	validates :client_bill_head_id, presence: true
	validates :product_id, presence: true
	
	def self.copyFromTemp(client_bill_head_id, ip)

		# it copies the temporary table into the client_bill_bodies and the deletes everything whith that IP from the table
		sql = "INSERT INTO client_bill_bodies (quantity, price, product_id, client_bill_head_id)
				SELECT quantity, price, product_id, #{client_bill_head_id}
				FROM client_bill_body_temps WHERE user_id = '#{ip.to_i}'"
		if ActiveRecord::Base.connection.execute sql
			sql = "DELETE FROM client_bill_body_temps WHERE user_id = '#{ip.to_i}'"
			ActiveRecord::Base.connection.execute sql
		end
	end

	def self.update_stock(ip)
		# sql = "SELECT bill_body_temps.quantity, bill_body_temps.price FROM product_data INNER JOIN bill_body_temps ON products.id=bill_body_temps.product_id AND bill_body_temps.user_id = '#{ip}' ;"
		# sql = "UPDATE product_data SET quantity=bill_body_temps.quantity, price=bill_body_temps.price FROM product_data AS pd INNER JOIN bill_body_temps ON pd.product_id=bill_body_temps.product_id "
		# ActiveRecord::Base.connection.execute sql
		@rows = ClientBillBodyTemp.where(user_id: ip.to_i)
		@rows.each do |row|
			sql = "UPDATE product_data SET quantity = quantity - #{row.quantity} WHERE product_data.product_id = #{row.product_id}"
			ActiveRecord::Base.connection.execute sql
		end
	end

	def self.rollback_stock(head_id)
		@rows = ClientBillBody.where(client_bill_head_id: head_id)
		@rows.each do |row|
			sql = "UPDATE product_data SET quantity = quantity + #{row.quantity} WHERE product_data.product_id = #{row.product_id}"
			ActiveRecord::Base.connection.execute sql
		end
	end

end
