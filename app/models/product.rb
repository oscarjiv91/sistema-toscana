class Product < ActiveRecord::Base
	belongs_to :iva
	belongs_to :category
	has_many :bill_body_temp
	has_many :supplier_bill_bodies
	has_one :product_datum, :dependent => :destroy
	accepts_nested_attributes_for :product_datum, allow_destroy: true

	validates :name, presence: true
	validates :cod, presence: true, uniqueness: true

	
	def self.search(search, category)
	  if !search.blank? || !category.blank?
	    #query_obj = Product.all
		query_obj = where("name ILIKE ? OR cod ILIKE ?", "%#{search}%", "%#{search}%") unless search.blank?
		if !category.blank?
			query_obj = where("category_id = ? AND (name ILIKE ? OR cod ILIKE ?)", "#{category}", "%#{search}%", "%#{search}%")
		end
		query_obj
	  else
	    scoped
	  end
	end

	def as_json(*args)
    	super.tap { |hash| hash["value"] = hash.delete "name" }
	end

end
