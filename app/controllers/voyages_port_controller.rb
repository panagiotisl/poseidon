class VoyagesPortController < ApplicationController
  
  
  def new
    @voyages_port = VoyagesPort.new
  end

  def create
    @voyages_port = VoyagesPort.new(voyages_port_params)
    if @voyages_port.save
      flash[:success] = "Port of Call added!"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id])
    else
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id]), :flash => { :error => "Please set a valid date and port of call." }
    end
  end
  
  private
  
    def voyages_port_params
      params.require(:voyages_port).permit(:voyage_id, :port_id, :date)
    end
end

