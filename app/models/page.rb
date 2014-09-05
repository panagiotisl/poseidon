class Page < ActiveRecord::Base
  belongs_to :shipping_company
  acts_as_list scope: :shipping_company
end
