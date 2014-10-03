class VoyagesPortController < ApplicationController
  
  
  def new
    @voyages_port = VoyagesPort.new
  end

  def create
    @voyages_port = VoyagesPort.new(voyages_port_params)
    if @voyages_port.save
      @subject = "#{current_user.shipping_company.name}:[#{@voyages_port.voyage.name} - #{@voyages_port.port.name} - #{@voyages_port.date}]"
      @content = "A new voyage has been registered."
      @agents = @voyages_port.port.agents.map{ |r| r }
      @receipts = Notification.notify_all(@agents  , @subject, @content)
      if @receipts
        @receipts.each do |receipt|
          Label.create(notification_id: receipt.notification.id, voyages_port_id: @voyages_port.id)
        end
      end

      @receipt = Notification.notify_all(current_user.shipping_company , @subject, @content)
      Label.create(notification_id: @receipt.notification.id, voyages_port_id: @voyages_port.id)

      flash[:success] = "Port of Call added!"
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id])
    else
      redirect_to shipping_company_fleet_ship_voyage_path(:id => params[:voyage_id]), :flash => { :error => "Please set a valid date and port of call." }
    end
  end

  def update
    @voyages_port = VoyagesPort.find params[:id]
    if @voyages_port.update_attributes(voyages_port_params)
      respond_to do |format|
        format.json { render :json => @voyages_port }
      end
    else
      respond_to do |format|
        format.json { render :nothing =>  true }
      end
    end
  end
  
  private
  
    def voyages_port_params
      params[:voyages_port][:remarks] = "No remarks yet. Click to add." if params[:voyages_port][:remarks].nil? || params[:voyages_port][:remarks].empty?
      params.require(:voyages_port).permit(:voyage_id, :port_id, :date, :remarks)
    end
end