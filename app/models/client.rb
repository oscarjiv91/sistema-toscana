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

	def self.getOverduePayers
		clients = find_by_sql("SELECT clients.id, clients.cod, clients.name, clients.last_name, clients.obs
							FROM
								(SELECT client_current_account_id, client_id
								FROM client_fees
								INNER JOIN client_current_accounts ON client_current_accounts.id = client_fees.client_current_account_id
								WHERE (expiration_date + ( '1 month'::INTERVAL)) < current_date AND ammount_paid < ammount
								GROUP BY client_current_account_id, client_id) as T1
							INNER JOIN clients ON T1.client_id = clients.id
							GROUP BY clients.id
							ORDER BY clients.last_name ASC")
		#clients = ClientCurrentAccount.where(client_id: self.id)
		
		clients
	end

	def self.search(id, search, obs)
	  if !search.blank? || !id.blank? || !obs.blank?
	    #query_obj = Client.all
		query_obj = where("name ILIKE ? OR last_name ILIKE ?", "%#{search}%", "%#{search}%") unless search.blank?
		#if !obs.blank?
		query_obj = where("obs ILIKE ?", "%#{obs}%") unless obs.blank?
		#end
		#query_obj = where("id ILIKE ?", "to_char(#{id})") unless id.blank?
		query_obj = where("cod ILIKE '%#{id}%'") unless id.blank?

		query_obj
	  else
	    scoped
	  end
	end
end
