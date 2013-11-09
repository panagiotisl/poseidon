class Ship < ActiveRecord::Base
  belongs_to :shipping_company
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
end
