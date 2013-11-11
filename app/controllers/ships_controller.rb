require 'common_stuff'
class ShipsController < ApplicationController
  include CommonStuff  
  before_action :authorized_sce,     only: [:new, :create]
  
  def new
    @title = "Create ship"
    @shipping_company = ShippingCompany.find(params[:id])
    @ship = Ship.new
  end
  
  def create
    @ship = Ship.new(ship_params)
    p params
    if @ship.save
      flash[:success] = "Ship created!"
      @shipping_company = ShippingCompany.find(params[:id])
      redirect_to @shipping_company
    else
      @title = "Create ship"
      @shipping_company = ShippingCompany.find(params[:id])
      render 'new'
    end
  end
  
  private
  
    def ship_params
      params.require(:ship).permit(:name, :shipping_company_id)
    end
      
end
