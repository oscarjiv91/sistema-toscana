class Salesman < ActiveRecord::Base
	belongs_to :supplier
	validates :name, presence: true, uniqueness: true
	validates :phone, presence: true
end
