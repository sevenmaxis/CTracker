class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :login, :password

	has_many :countries, :dependent => :destroy
	has_many :currencies, :dependent => :destroy

	validates :login, :presence => true, :uniqueness => true
	validates :password, :presence => true

	before_save :encrypt_password

	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end

	class << self
		def authenticate(login, submitted_password)
			user = find_by_login(login)
			(user && user.has_password?(submitted_password)) ? user : nil
		end

		def authenticate_with_salt(id, cookie_salt)
			user = find_by_id(id)
			(user && user.salt == cookie_salt) ? user : nil
		end
	end

	private

	def encrypt_password
		self.salt = make_salt unless has_password?(password)
		self.encrypted_password = encrypt(password)
	end

	def encrypt(string)
		secure_hash("#{salt}--#{string}")
	end

	def make_salt
		secure_hash("#{Time.now.utc}--#{password}")
	end

	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end
end
