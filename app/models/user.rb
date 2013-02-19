class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessor :login, :password

	has_many :countries, :dependent => :destroy
	has_many :currencies, :dependent => :destory

	before_save :encrypt_password

	def has_password?(submitted_password)
		encrypt_password == encrypt(submitted_password)
	end

	class << self
		def authenticate(login, submitted_password)
			user = find_by_login(login)
			(user && user.has_password?(submitted_password)) ? user : nil
		end

		def authenitcate_with_salt(id, cookie_salt)
			user = find_by_id(id)
			(user && user.salt == cookie_salt) ? user : nil
		end
	end

	private

	def encrypt_password
		self.salt = make_salt unless has_password?(password)
		self.encrypt_password = encrypt(password)
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
