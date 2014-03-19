class Reader < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification
  
  validates_uniqueness_of :user_id, :scope => :notification_id
  
end
