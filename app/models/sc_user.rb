class SCUser < User
  belongs_to :shippingcompany, foreign_key: "shipping_company_id"
  validates :shipping_company_id, presence: true

  def self.model_name
    User.model_name
  end
end
