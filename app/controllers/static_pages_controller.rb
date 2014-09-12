class StaticPagesController < ApplicationController

  def home
    if signed_in?
      if sce?
        @fleets = current_user.shipping_company.fleets
        @ships = current_user.shipping_company.ships
        @voyages = current_user.shipping_company
      elsif ase?
        @fleets = Fleet.none
        @voyages_ports = current_user.agent.voyages_ports
      end
      @notifications = Notification.order('created_at DESC').where("id IN (SELECT notification_id FROM receipts where mailbox_type is null and receiver_id=:receiver_id and receiver_type=:receiver_type order by created_at desc)", receiver_id: get_company_id, receiver_type: get_company_type).paginate(page: params[:page], per_page: 5)
    end
  end
  
  def help
  end

  def about
  end

  def contact
  end

  def search
    @term = params[:term]
    if sce?
        @fleets = current_user.shipping_company.fleets
        @ships = current_user.shipping_company.ships
        @voyages = current_user.shipping_company.voyages
      elsif ase?
        @fleets = Fleet.none
        @voyages_ports = current_user.agent.voyages_ports
      end
      @es_agents = Agent.search @term, page: params[:agents_page], per_page: 5, fields: [{name: :word_start}]
      @es_shippingCompanies = ShippingCompany.search @term, page: params[:sc_page], per_page: 5, fields: [{name: :word_start}]
      @es_ports = Port.search @term, page: params[:ports_page], per_page: 5, fields: [{name: :word_start}]
  end

end
