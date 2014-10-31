class ShipsController < ApplicationController
  before_action :authorized_sce,     only: [:index, :new, :create, :edit]
  
  def index

    @fleet = Fleet.find(params[:fleet_id])
    @shipping_company = @fleet.shipping_company
    @fleets = @shipping_company.fleets
    if params[:vessel_type]
      @ships = @fleet.ships.where(:vessel_type_id => params[:vessel_type]).paginate(page: params[:page])
      @title = "#{VesselType.find(params[:vessel_type]).category} Ships"
    else
      @ships = @fleet.ships.paginate(page: params[:page])
      @title = "All Ships"
    end

  end
  
  def show
    #@shipping_company = ShippingCompany.find(params[:shipping_company_id])
    #@fleet = Fleet.find(params[:fleet_id])
    @ship = Ship.find(params[:id])
    @title = @ship.name
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
    @fleets = @shipping_company.fleets
    @voyages = @ship.voyages.paginate(page: params[:page])
  end

  
  def new
    @title = "Create ship"
    #@shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @fleet = Fleet.find(params[:fleet_id])
    @shipping_company = @fleet.shipping_company
    @fleets = @shipping_company.fleets
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
      @fleets = @shipping_company.fleets
      redirect_to shipping_company_fleet_ship_path(:id => @ship.id)
    else
      @title = "Create ship"
      #@shipping_company = ShippingCompany.find(params[:shipping_company_id])
      #@fleet = Fleet.find(params[:fleet_id])
      @fleet = @ship.fleet
      @shipping_company = @fleet.shipping_company
      @fleets = @shipping_company.fleets
      render 'new'
    end
  end
  
  def edit
    @title = "Edit ship"
    @ship = Ship.find(params[:id])
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
    @fleets = @shipping_company.fleets
  end

  def update
    @ship = Ship.find(params[:id])
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
    @fleets = @shipping_company.fleets
    if @ship.update_attributes(ship_params)
      flash[:success] = "Ship updated"
      redirect_to shipping_company_fleet_ship_path(:id => @ship.id)
    else
      render 'edit'
    end
  end

  def list
    @title = 'List'
    @ship = Ship.find(params[:ship_id])
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
    @fleets = @shipping_company.fleets
  end

  private
  
    def ship_params
      params.require(:ship).permit(:name, :fleet_id, :flag_id, :vessel_type_id, :port_id, :registry_no, :built_date, :yard_built,
                                    :imo_no, :hull_no, :call_sign,
                                    :dwt_summer, :dwt_winter, :dwt_tropical_salt, :dwt_tropical_fresh, :dwt_winter_north_altantic,
                                    :draft_summer, :draft_winter, :draft_tropical_salt, :draft_tropical_fresh, :draft_winter_north_altantic)
    end

end
