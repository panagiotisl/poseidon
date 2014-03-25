class OffersController < ApplicationController
  
  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      @voyages_port = @offer.need.voyages_port
      Notification.notify_all(@offer.need.shipping_company, "#{@voyages_port.voyage.name} - #{@voyages_port.port.name} - #{@voyages_port.date}: New offer for #{@offer.need.service.category}", "Agent #{@offer.agent.name} has made a new offer for #{@offer.need.service.category}.")
      flash[:success] = "Offer added!"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port])
    else
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port]), :flash => { :error => "Wrong arguments!" }
    end
  end

  def update
    @offer = Offer.find(params[:offer_id])
    if params[:commit] == "Withdraw Offer"
      @voyages_port = @offer.need.voyages_port
      Notification.notify_all(@offer.need.shipping_company, "#{@voyages_port.voyage.name} - #{@voyages_port.port.name} - #{@voyages_port.date}: Offer for #{@offer.need.service.category} withdrawn", "Agent #{@offer.agent.name} has withdrawn the offer for #{@offer.need.service.category}.")
      
      @offer.destroy
      flash[:success] = "Offer withdrawn"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id],:voyage_port => params[:voyage_port])
    else
      if @offer.update_attributes(offer_params)
        @voyages_port = @offer.need.voyages_port
        Notification.notify_all(@offer.need.shipping_company, "#{@voyages_port.voyage.name} - #{@voyages_port.port.name} - #{@voyages_port.date}: Offer for #{@offer.need.service.category} updated", "Agent #{@offer.agent.name} has updated the offer for #{@offer.need.service.category}.")
        
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
