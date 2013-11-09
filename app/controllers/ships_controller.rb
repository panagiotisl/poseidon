class ShipsController < ApplicationController
  
  
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
      @shipping_company = ShippingCompany.find(params[:ship][:shipping_company_id])
      redirect_to @shipping_company
    else
      @title = "Create ship"
      @shipping_company = ShippingCompany.find(params[:ship][:shipping_company_id])
      render 'new'
    end
  end
  
  private
  
    def ship_params
      params.require(:ship).permit(:name, :shipping_company_id)
    end
    
  
end
