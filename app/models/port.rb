class Port < ActiveRecord::Base
  belongs_to :country
  has_many :voyages, foreign_key: "port_id"
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :country_id, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
end
