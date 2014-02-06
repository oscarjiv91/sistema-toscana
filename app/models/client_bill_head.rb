class ClientBillHead < ActiveRecord::Base
	has_many :client_bill_body, :dependent => :delete_all
	has_one :client_current_account, :dependent => :destroy
	belongs_to :clients
	# set to nil so you can use the name "type" as a column name in your table	
	self.inheritance_column = nil

	validates :date, presence: true
	validates :number, presence: true
	validates :type, presence: true
	validates :total, presence: true

	def self.search(product)
	  if product

	  	query_obj = ClientBillHead.joins("INNER JOIN client_bill_bodies ON client_bill_bodies.client_bill_head_id = client_bill_heads.id").joins("INNER JOIN products ON client_bill_bodies.product_id = products.id").where("products.name ILIKE \'%#{product}%\' OR products.cod ILIKE \'%#{product}%\'").group("client_bill_heads.id")
	  	#query_obj = query_obj.joins(:product)
	  	query_obj
	 #    query_obj = SupplierBillHead.all
		# query_obj = where("name ILIKE ? OR cod ILIKE ?", "%#{search}%", "%#{search}%") unless search.blank?
		# if !category.blank?
		# 	query_obj = where("category_id = ? AND (name ILIKE ? OR cod ILIKE ?)", "#{category}", "%#{search}%", "%#{search}%")
		# end
		# query_obj
	 #  else
	 #    scoped
	 else
	 	scoped
	  end
	end
end
