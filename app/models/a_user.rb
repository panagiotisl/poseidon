class AUser < User
  belongs_to :agent, foreign_key: "agent_id"
  validates :agent_id, presence: true

  def self.model_name
    User.model_name
  end
end
