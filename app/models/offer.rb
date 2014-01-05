class Offer < ActiveRecord::Base
  belongs_to :agent
  belongs_to :need
  validates :value, presence: true, :numericality => { :greater_than => 0 }
  validates :quantity, presence: true, :inclusion => 1..100
  validates :agent_id, presence: true
  validates :need_id, presence: true
end
