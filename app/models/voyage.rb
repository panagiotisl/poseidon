class Voyage < ActiveRecord::Base
  belongs_to :ship
  belongs_to :port
  has_many :needs, foreign_key: "voyage_id", dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :date, presence: true
  validates :ship_id, presence: true
  validates :port_id, presence: true
end
