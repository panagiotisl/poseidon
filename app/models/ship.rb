class Ship < ActiveRecord::Base
  belongs_to :fleet
  belongs_to :flag
  belongs_to :vessel_type
  has_many :voyages, foreign_key: "ship_id", dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :fleet_id, presence: true
  validates :vessel_type_id, presence: true
  validates :flag_id, presence: true
end
