class NeedsController < ApplicationController
  
  def create
    @need = Need.new(need_params)
    if @need.save
      flash[:success] = "Need added!"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port])
    else
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port]), :flash => { :error => "Need should not be already added to the voyage and quantity must be set between 1 and 100!" }
    end
  end
  
  private
  
    def need_params
      params.require(:need).permit(:quantity, :voyages_port_id, :service_id)
    end
end
