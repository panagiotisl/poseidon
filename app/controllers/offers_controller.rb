class OffersController < ApplicationController
  
  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      flash[:success] = "Offer added!"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port])
    else
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port]), :flash => { :error => "Wrong arguments!" }
    end
  end

  def update
    if params[:commit] == "Withdraw Offer"
      Offer.find(params[:offer_id]).destroy
      flash[:success] = "Offer withdrawn"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id],:voyage_port => params[:voyage_port])
    else
      @offer = Offer.find(params[:offer_id])
      if @offer.update_attributes(offer_params)
        flash[:success] = "Offer updated"
        redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port])
      else
        flash[:fail] = "Something went wrong!"
        redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port])
      end
    end
  end
  
  def accept
    @offer = Offer.find(params[:offer_id])
    if @offer.toggle!(:accepted)
      flash[:success] = "Offer updated"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port])
    else
      flash[:fail] = "Something went wrong!"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port])
    end
  end

  private
  
    def offer_params
      params.require(:offer).permit(:value, :quantity, :need_id, :agent_id)
    end
end
