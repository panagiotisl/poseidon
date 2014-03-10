class Need < ActiveRecord::Base
  belongs_to :service
  belongs_to :voyages_ports
  has_many :offers, foreign_key: "need_id", dependent: :destroy 
  #validates :quantity, presence: true, :inclusion => 1..100
  validates :service_id, presence: true
  validates :voyages_port_id, presence: true
  validates_uniqueness_of :service_id, :scope => :voyages_port_id
end
