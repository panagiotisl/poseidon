class Agent < ActiveRecord::Base
  belongs_to :country
  has_many :operations, foreign_key: "agent_id", dependent: :destroy
  has_many :ports, through: :operations, source: :port
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :address, presence: true
  validates :telephone, presence: true
  validates :country_id, presence: true

  def operating_on?(port_id)
    operations.find_by(port_id: port_id)
  end

  def register!(port_id)
    operations.create!(port_id: port_id)
  end

#  def unregister!(port)
#    operations.find_by(port_id: port.id).destroy!
#  end

end
