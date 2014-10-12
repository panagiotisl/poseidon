class VoyagesController < ApplicationController
  
  before_filter :signed_in_user,    only: [:show]           
  before_filter :authorized_sce,    only: [:index, :new, :create, :edit, :update, :accept]
  
  def index
    @title = "All Voyages"
    @ship = Ship.find(params[:ship_id])
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
    @voyages = @ship.voyages.paginate(page: params[:page])
  end
  
  def show
    @voyage = Voyage.find(params[:id])
    if params[:voyage_port]
      @voyages_port = VoyagesPort.find(params[:voyage_port])
      @needs = @voyages_port.needs
      @agents, @altNeeds, @totals, @accepted = find_needs(@needs)
    else
      @voyages_port = VoyagesPort.new
    end
    @ship = @voyage.ship
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
    @fleets = @shipping_company.fleets
    @title = @voyage.name
    @need = Need.new 
    @offer = Offer.new
    
  end
  
  def new
    @title = "Create voyage"
    @ship = Ship.find(params[:ship_id])
    @fleet = @ship.fleet
    @shipping_company = @fleet.shipping_company
    @fleets = @shipping_company.fleets
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
    @fleets = @shipping_company.fleets
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
  
  def accept
    @voyage_port = VoyagesPort.find(params[:voyage_port])
    @voyage_port.needs.each do |need|
      offers = need.offers
      offers.each do |offer|
        if offer.agent.id.to_s == params[:agent]
          @agent = offer.agent
          offer.toggle!(:accepted)
        end
      end
    end
    @subject = "#{current_user.shipping_company.name}:[#{@voyage_port.voyage.name} - #{@voyage_port.port.name} - #{@voyage_port.date}]"
    @content = "There was an update regarding offers for this this voyage."
    @agents = @voyage_port.port.agents.map{ |r| r }
    @receipts = Notification.notify_all(@agents  , @subject, @content)
    if @receipts
      [*@receipts].each do |receipt|
        Label.create(notification_id: receipt.notification.id, voyages_port_id: @voyage_port.id)
      end
    end

    @receipt = Notification.notify_all(current_user.shipping_company , @subject, @content)
    Label.create(notification_id: @receipt.notification.id, voyages_port_id: @voyage_port.id)

    flash[:success] = "Offer status updated"
    redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id], :voyage_port => params[:voyage_port], :alt => params[:alt])
  end
  
  private
  
    def voyage_params
      params.require(:voyage).permit(:name, :ship_id)
    end
  
    def find_needs(needs)
      agents = Set.new
      altNeeds = Hash.new
      totals = Hash.new
      accepted = nil
      needs.each do |need|
        need.offers.each do |offer|
          agents << offer.agent
          if offer.accepted
             accepted = offer.agent
          end
          altNeeds[[need.id,offer.agent.id]] = offer
          if totals[offer.agent]
            totals[offer.agent] += offer.value*offer.quantity
          else
            totals[offer.agent] = offer.value*offer.quantity
          end
        end
      end
      return agents,altNeeds,totals, accepted
    end
    
end
