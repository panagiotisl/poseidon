class Page < ActiveRecord::Base
  belongs_to :shipping_company
  
  include RankedModel
  ranks :position
end
