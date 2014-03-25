class Label < ActiveRecord::Base
  belongs_to :notification
  belongs_to :voyages_port
  
  validates_uniqueness_of :notification_id
  
end
