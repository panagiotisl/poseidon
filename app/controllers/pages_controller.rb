class PagesController < ApplicationController

  before_filter :get_fleets
  
  def index
    @pages = ShippingCompany.find(params[:shipping_company_id]).pages    
  end
  
  
  def sort
  end
  
end
