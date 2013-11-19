class Voyage < ActiveRecord::Base
  belongs_to :ship
  belongs_to :port
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :date, presence: true
  validates :ship_id, presence: true
  validates :port_id, presence: true
end
