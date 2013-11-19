require 'common_stuff'
class ShipsController < ApplicationController
  include CommonStuff  
  before_action :authorized_sce,     only: [:index, :new, :create]
  
  def index
    @title = "All Ships"
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @ships = @shipping_company.ships.paginate(page: params[:page])
  end
  
  def show
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @ship = Ship.find(params[:id])
    @title = @ship.name 
    @voyages = @ship.voyages.paginate(page: params[:page])
  end

  
  def new
    @title = "Create ship"
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @ship = Ship.new
  end
  
  def create
    @ship = Ship.new(ship_params)
    p params
    if @ship.save
      flash[:success] = "Ship created!"
      @shipping_company = ShippingCompany.find(params[:shipping_company_id])
      redirect_to @shipping_company
    else
      @title = "Create ship"
      @shipping_company = ShippingCompany.find(params[:shipping_company_id])
      render 'new'
    end
  end
  
  private
  
    def ship_params
      params.require(:ship).permit(:name, :shipping_company_id)
    end
      
end
