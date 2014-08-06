class Port < ActiveRecord::Base
  belongs_to :country
  #has_many :voyages, foreign_key: "port_id"
  #has_and_belongs_to_many :voyages
  has_many :voyages_ports
  has_many :voyages, :through => :voyages_ports
  has_many :operations
  has_many :agents, :through => :operations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :country_id, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  
  searchkick word_start: [:name]
  
end
