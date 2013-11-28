class ShipsController < ApplicationController
  before_action :authorized_sce,     only: [:index, :new, :create]
  
  def index
    @title = "All Ships"
    #@shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @fleet = Fleet.find(params[:fleet_id])
    @shipping_company = @fleet.shipping_company
    @ships = @fleet.ships.paginate(page: params[:page])
  end
  
  def show
    #@shipping_company = ShippingCompany.find(params[:shipping_company_id])
    #@fleet = Fleet.find(params[:fleet_id])
    @ship = Ship.find(params[:id])
    @title = @ship.name
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
    @voyages = @ship.voyages.paginate(page: params[:page])
  end

  
  def new
    @title = "Create ship"
    #@shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @fleet = Fleet.find(params[:fleet_id])
    @shipping_company = @fleet.shipping_company
    @ship = Ship.new
  end
  
  def create
    @ship = Ship.new(ship_params)
    p params
    if @ship.save
      flash[:success] = "Ship created!"
      #@shipping_company = ShippingCompany.find(params[:shipping_company_id])
      #@fleet = Fleet.find(params[:fleet_id])
      @fleet = @ship.fleet
      @shipping_company = @fleet.shipping_company
      redirect_to shipping_company_fleet_ship_path(:id => @ship.id)
    else
      @title = "Create ship"
      #@shipping_company = ShippingCompany.find(params[:shipping_company_id])
      #@fleet = Fleet.find(params[:fleet_id])
      @fleet = @ship.fleet
      @shipping_company = @fleet.shipping_company
      render 'new'
    end
  end
  
  def edit
    @title = "Edit ship"
    #@shipping_company = ShippingCompany.find(params[:shipping_company_id])
    #@fleet = Fleet.find(params[:fleet_id])
    @ship = Ship.find(params[:id])
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
  end

  def update
    @ship = Ship.find(params[:id])
    if @ship.update_attributes(ship_params)
      flash[:success] = "Ship updated"
      redirect_to shipping_company_fleet_ship_path(:id => @ship.id)
    else
      render 'edit'
    end
  end
  
  private
  
    def ship_params
      params.require(:ship).permit(:name, :fleet_id, :vessel_type_id)
    end
      
end
