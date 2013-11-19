class Ship < ActiveRecord::Base
  belongs_to :shipping_company
  has_many :voyages, foreign_key: "ship_id", dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
end
