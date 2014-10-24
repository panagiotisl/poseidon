class OffersController < ApplicationController

  before_filter :signed_in_user
  
  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      @voyages_port = @offer.need.voyages_port
      @receipt = Notification.notify_all(@offer.need.shipping_company, "[#{@voyages_port.voyage.name} - #{@voyages_port.port.name} - #{@voyages_port.date}] New offer for #{@offer.need.service.category}", "Agent #{@offer.agent.name} has made a new offer for #{@offer.need.service.category}.")
      Label.create(notification_id: @receipt.notification.id, voyages_port_id: @voyages_port.id)
      flash[:success] = "Offer added!"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port], :vessel_type => params[:vessel_type])
    else
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port], :vessel_type => params[:vessel_type]), :flash => { :error => "Wrong arguments!" }
    end
  end

  def update
    @offer = Offer.find(params[:offer_id])
    if params[:commit] == "Withdraw Offer"
      @voyages_port = @offer.need.voyages_port
      @subject = "#{current_user.agent.name}:[#{@voyages_port.voyage.name} - #{@voyages_port.port.name} - #{@voyages_port.date}] Offer for #{@offer.need.service.category} withdrawn"
      @content = "Agent #{@offer.agent.name} has withdrawn the offer for #{@offer.need.service.category}."

      @receipt = Notification.notify_all(@offer.need.shipping_company, @subject, @content)
      Label.create(notification_id: @receipt.notification.id, voyages_port_id: @voyages_port.id)

      @receipt = Notification.notify_all(current_user.agent, @subject, @content)
      Label.create(notification_id: @receipt.notification.id, voyages_port_id: @voyages_port.id)

      @offer.destroy
      flash[:success] = "Offer withdrawn"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id],:voyage_port => params[:voyage_port], :vessel_type => params[:vessel_type])
    else
      if @offer.update_attributes(offer_params)
        @voyages_port = @offer.need.voyages_port
        @subject = "#{current_user.agent.name}:[#{@voyages_port.voyage.name} - #{@voyages_port.port.name} - #{@voyages_port.date}] Offer for #{@offer.need.service.category} updated"
        @content = "Agent #{@offer.agent.name} has updated the offer for #{@offer.need.service.category}."

        @receipt = Notification.notify_all(@offer.need.shipping_company, @subject, @content)
        Label.create(notification_id: @receipt.notification.id, voyages_port_id: @voyages_port.id)

        @receipt = Notification.notify_all(current_user.agent, @subject, @content)
        Label.create(notification_id: @receipt.notification.id, voyages_port_id: @voyages_port.id)


        flash[:success] = "Offer updated"
        redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port], :vessel_type => params[:vessel_type])
      else
        flash[:fail] = "Something went wrong!"
        redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port], :vessel_type => params[:vessel_type])
      end
    end
  end
  
  def accept
    @offer = Offer.find(params[:offer_id])
    if @offer.toggle!(:accepted)
      flash[:success] = "Offer updated"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port], :vessel_type => params[:vessel_type])
    else
      flash[:fail] = "Something went wrong!"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port], :vessel_type => params[:vessel_type])
    end
  end

  private
  
    def offer_params
      params.require(:offer).permit(:value, :quantity, :need_id, :agent_id)
    end
end
