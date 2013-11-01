class Country < ActiveRecord::Base
  validates :iso, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :printableName, presence: true, uniqueness: { case_sensitive: false }
end
