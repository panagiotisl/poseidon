class Voyage < ActiveRecord::Base
  belongs_to :ship
  delegate :shipping_company, :to => :ship
  #belongs_to :port
  #has_and_belongs_to_many :ports
  has_many :voyages_ports, foreign_key: "voyage_id"
  has_many :ports, :through => :voyages_ports
  #has_many :needs, foreign_key: "voyage_id", dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
#  validates :remarks, length: { maximum: 1000 }
#  validates :date, presence: true
  validates :ship_id, presence: true
#  validates :port_id, presence: true
end
