class ProductDatum < ActiveRecord::Base
 belongs_to :products

 validates :quantity, presence: true
 validates :price, presence: true
end
