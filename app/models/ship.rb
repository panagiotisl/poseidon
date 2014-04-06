class Ship < ActiveRecord::Base
  belongs_to :fleet
  belongs_to :flag
  belongs_to :vessel_type
  
  delegate :shipping_company, :to => :fleet
  
  has_many :voyages, foreign_key: "ship_id", dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :fleet_id, presence: true
  validates :vessel_type_id, presence: true
  validates :flag_id, presence: true
  validates :registry_no, :numericality => {:only_integer => true}
  validates :imo_no, :numericality => {:only_integer => true}
  validates :hull_no, :numericality => {:only_integer => true}
  
  validates :yard_built, length: { maximum: 50 }
  validates :call_sign, length: { maximum: 50 }
  
end
