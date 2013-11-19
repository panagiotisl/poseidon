require 'common_stuff'
class VoyagesController < ApplicationController
  include CommonStuff  
  before_action :authorized_sce,     only: [:index, :new, :create]
  
  def index
    @title = "All Voayges"
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @ship = Ship.find(params[:ship_id])
    @voyages = @ships.voyages.paginate(page: params[:page])
  end
  
  def show
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @voyage = Voyage.find(params[:id])
    @title = @voyage.name 
  end
  
  def new
    @title = "Create voyage"
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @voyage = Voyage.new
  end
  
  def create
    @voyage = Voyage.new(voyage_params)
    if @voyage.save
      flash[:success] = "Voyage created!"
      @shipping_company = ShippingCompany.find(params[:shipping_company_id])
      redirect_to @shipping_company
    else
      @title = "Create Voyage"
      @shipping_company = ShippingCompany.find(params[:shipping_company_id])
      render 'new'
    end
  end
  
  private
  
    def voyage_params
      params.require(:voyage).permit(:name, :ship_id, :port_id, :date)
    end
end
