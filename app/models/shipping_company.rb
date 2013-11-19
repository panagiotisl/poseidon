class ShippingCompany < ActiveRecord::Base
  belongs_to :country
  has_many :ships, foreign_key: "shipping_company_id", dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :address, presence: true
  validates :telephone, presence: true
  validates :country_id, presence: true
end
