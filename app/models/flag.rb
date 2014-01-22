class Flag < ActiveRecord::Base
  has_many :ships, foreign_key: "flag_id", dependent: :destroy
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :path, presence: true
end
