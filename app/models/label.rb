class Label < ActiveRecord::Base
  belongs_to :notification
  belongs_to :conversation
  belongs_to :voyages_port
  
  validates_uniqueness_of :voyages_port_id, :scope => [:notification_id, :conversation_id]
  
end
