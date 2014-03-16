class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  #acts_as_messageable 

  TYPE = [['Shipping Company Employee', 'SCUser'], ['Agent/Supplier Employee', 'AUser']]
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

 # def mailboxer_email(object)
  #Check if an email should be sent for that object
  #if true
 #   return :email
  #if false
  #return nil
 # end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
