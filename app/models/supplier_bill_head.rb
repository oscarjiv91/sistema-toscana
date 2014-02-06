class SupplierBillHead < ActiveRecord::Base
	has_many :supplier_bill_body, :dependent => :delete_all
	belongs_to :supplier
	# set to nil so you can use the name "type" as a column name in your table	
	self.inheritance_column = nil

	validates :date, presence: true
	validates :number, presence: true
	validates :type, presence: true
	validates :total, presence: true
	validates :supplier_id, presence: true

	def self.search(supplier, product)
	  if supplier
	  	# query_obj = SupplierBillHead.joins(:supplier).where("suppliers.name ILIKE \'%#{supplier}%\'")	  
	  	query_obj = SupplierBillHead.joins("INNER JOIN suppliers ON suppliers.id = supplier_bill_heads.supplier_id").where("suppliers.name ILIKE \'%#{supplier}%\'")	  	
	  	if !product.blank?
	  		query_obj = query_obj.joins("INNER JOIN supplier_bill_bodies ON supplier_bill_bodies.supplier_bill_head_id = supplier_bill_heads.id").joins("INNER JOIN products ON supplier_bill_bodies.product_id = products.id").where("products.name ILIKE \'%#{product}%\' OR products.cod ILIKE \'%#{product}%\'").group("supplier_bill_heads.id")
	  		#query_obj = group("supplier_bill_heads.id")
	  	end
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
