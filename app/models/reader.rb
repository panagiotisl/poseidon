class Reader < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification
  belongs_to :conversation
  
  validates_uniqueness_of :user_id, :scope => [:notification_id, :conversation_id]
end
