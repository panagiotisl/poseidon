class Agent < ActiveRecord::Base
  belongs_to :country
  has_many :operations, foreign_key: "agent_id", dependent: :destroy
  has_many :ports, through: :operations, source: :port
  has_many :voyages_ports, through: :ports
  has_many :offers, foreign_key: "agent_id", dependent: :destroy
  has_many :agent_pages
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validate :name_not_on_shipping_companies
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :address, presence: true
  validates :telephone, presence: true
  validates :country_id, presence: true
  
  acts_as_messageable
  searchkick word_start: [:name]

  def operating_on?(port_id)
    operations.find_by(port_id: port_id)
  end

  def register!(port_id)
    operations.create!(port_id: port_id)
  end

#  def unregister!(port)
#    operations.find_by(port_id: port.id).destroy!
#  end

  def mailboxer_email(object)
    return :email
  end
  
  private
  
    def name_not_on_shipping_companies
      uname=ShippingCompany.where(:name => self.name).first
      uname.nil?
      unless uname.nil?
        errors.add(:name, "Name already used")
      end
    end

end
