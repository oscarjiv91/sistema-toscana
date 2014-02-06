class User < ActiveRecord::Base
	belongs_to :user_group
	validates_presence_of :username
	validates_presence_of :name
	validates_presence_of :password, :on => :create
	has_secure_password
	before_save { self.username = username.downcase }
	before_create :create_remember_token

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
