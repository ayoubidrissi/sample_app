# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#

class User < ActiveRecord::Base
  attr_accessor :password	
  attr_accessible :email, :name, :password, :password_confirmation, :salt

  email_regex = /[\w\-.]+@[a-z\d\-.]+\.[a-z]+/
  validates :name, :presence => true,
  				   :length => {:maximum => 30 }

  validates :email, :presence => true,
  				    :format => {:with => email_regex},
  				    :uniqueness => {:case_sensitive => false}

  validates :password, :presence => true,
  					   :confirmation => true,
  					   :length => { :within => 8..20 }

  before_save :encrypt_password

  def has_password?(submitted_password)    
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email,password)
       user = find_by_email(email)
       return nil if user.nil?
       return user if user.has_password?(password)
  end

  private

  	def encrypt_password
      self.salt = make_salt
  		self.encrypted_password = encrypt(password)	  					   	
  	end	  	

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

  	def encrypt(password)
      secure_hash("#{salt}--#{password}")  					   
  	end			

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)       
    end	   
end
