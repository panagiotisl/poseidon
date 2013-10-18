class Affiliation < ActiveRecord::Base
  has_many :users
  belongs_to :categories, primary_key: "id", foreign_key: "category_id"
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :category_id, presence: true
end
