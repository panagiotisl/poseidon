class VoyagesPortController < ApplicationController
  
  
  def new
    @voyages_port = VoyagesPort.new
  end

  def create
    @voyages_port = VoyagesPort.new(voyages_port_params)
    if @voyages_port.save
      @agents = @voyages_port.port.agents.map{ |r| r }
      @receipts = Notification.notify_all(@agents  , "#{@voyages_port.voyage.name} - #{@voyages_port.port.name} - #{@voyages_port.date}", "A new voyage has been registered.")
      if @receipts
        @receipts.each do |receipt|
          Label.create(notification_id: receipt.notification.id, voyages_port_id: @voyages_port.id)
        end
      end
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

