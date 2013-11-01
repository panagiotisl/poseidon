class ShippingCompany < ActiveRecord::Base
  belongs_to :countries, primary_key: "id", foreign_key: "country_id"
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
