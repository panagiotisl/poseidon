class VoyagesPort < ActiveRecord::Base
  belongs_to :voyage
  belongs_to :port
  
  delegate :shipping_company, :to => :voyage
  
  has_many :needs, foreign_key: "voyages_port_id", dependent: :destroy
  
  validates :date, presence: true
  validates :voyage_id, presence: true
  validates :port_id, presence: true
end
