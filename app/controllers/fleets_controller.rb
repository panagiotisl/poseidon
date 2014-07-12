class FleetsController < ApplicationController

  before_filter :signed_in_user
  before_action :authorized_sce,     only: [:index, :new, :create, :edit]
  before_action :get_fleets,     only: [:index, :show]
  
  def index
    @title = "All Fleets"
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
  end
  
  def show
    @fleet = Fleet.find(params[:id])
    @shipping_company = @fleet.shipping_company
    @title = @fleet.name 
    @ships = @fleet.ships.paginate(page: params[:page])
    @voyages = @fleet.voyages.paginate(page: params[:page])
  end

  
  def new
    @title = "Create fleet"
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @fleets = @shipping_company.fleets
    @fleet = Fleet.new
  end
  
  def create
    @fleet = Fleet.new(fleet_params)
    p params
    if @fleet.save
      flash[:success] = "Fleet created!"
      @shipping_company = ShippingCompany.find(params[:shipping_company_id])
      redirect_to shipping_company_fleet_path(:id => @fleet.id)
    else
      @title = "Create fleet"
      @shipping_company = ShippingCompany.find(params[:shipping_company_id])
      render 'new'
    end
  end
  
  
  def edit
    @title = "Edit fleet"
    @fleet = Fleet.find(params[:id])
    @shipping_company = @fleet.shipping_company
    @fleets = @shipping_company.fleets
  end

  def update
    @fleet = Fleet.find(params[:id])
    if @fleet.update_attributes(fleet_params)
      flash[:success] = "Fleet updated"
      redirect_to shipping_company_fleet_path(:id => @fleet.id)
    else
      render 'edit'
    end
  end
  
  private
  
    def fleet_params
      params.require(:fleet).permit(:name, :shipping_company_id)
    end
      

end
