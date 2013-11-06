class Port < ActiveRecord::Base
  belongs_to :country
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :country_id, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
end
