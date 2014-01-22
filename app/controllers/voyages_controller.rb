require 'common_stuff'
class VoyagesController < ApplicationController
  include CommonStuff  
  before_action :authorized_sce,     only: [:index, :new, :create, :edit]
  
  def index
    @title = "All Voyages"
    #@shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @ship = Ship.find(params[:ship_id])
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
    @voyages = @ship.voyages.paginate(page: params[:page])
  end
  
  def show
    @voyage = Voyage.find(params[:id])
    @ship = @voyage.ship
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
    @title = @voyage.name
    @needs = @voyage.needs
    @need = Need.new 
    @offer = Offer.new
  end
  
  def new
    @title = "Create voyage"
    @ship = Ship.find(params[:ship_id])
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
    @voyage = Voyage.new
  end
  
  def create
    @voyage = Voyage.new(voyage_params)
    if @voyage.save
      flash[:success] = "Voyage created!"
      @shipping_company = ShippingCompany.find(params[:shipping_company_id])
      redirect_to shipping_company_fleet_ship_voyage_path(:id => @voyage.id)
    else
      @title = "Create Voyage"
      @shipping_company = ShippingCompany.find(params[:shipping_company_id])
      render 'new'
    end
  end
  
  def edit
    @title = "Edit voyage"
    @voyage = Voyage.find(params[:id])
    @ship = @voyage.ship
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
  end

  def update
    @voyage = Voyage.find(params[:id])
    if @voyage.update_attributes(voyage_params)
      flash[:success] = "Voyage updated"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => @voyage.id)
    else
      render 'edit'
    end
  end
  
  private
  
    def voyage_params
      params.require(:voyage).permit(:name, :remarks, :ship_id, :port_id, :date)
    end
end
