class AgentPage < ActiveRecord::Base
  belongs_to :agent
  
  include RankedModel
  ranks :position

end
