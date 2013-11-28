class FleetsController < ApplicationController
  
  before_action :authorized_sce,     only: [:index, :new, :create, :edit]
  
  def index
    @title = "All Fleets"
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @fleets = @shipping_company.fleets.paginate(page: params[:page])
  end
  
  def show
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @fleet = Fleet.find(params[:id])
    @title = @fleet.name 
    @ships = @fleet.ships.paginate(page: params[:page])
  end

  
  def new
    @title = "Create fleet"
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
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
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
    @fleet = Fleet.find(params[:id])
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
