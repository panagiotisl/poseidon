class Operation < ActiveRecord::Base
  belongs_to :agent
  belongs_to :port
  validates :agent_id, presence: true
  validates :port_id, presence: true


  def unregister!
    self.destroy!
  end

end
