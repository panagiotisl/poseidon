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
    @agent = current_user.agent
    if sce?
        @fleets = current_user.shipping_company.fleets
        @ships = current_user.shipping_company.ships
        @voyages = current_user.shipping_company.voyages
      elsif ase?
        @fleets = Fleet.none
        @voyages_ports = current_user.agent.voyages_ports
      end
      @es_agents = Agent.search @term, page: params[:page], per_page: 20
      @es_shippingCompanies = ShippingCompany.search @term, page: params[:page], per_page: 20
      @es_ports = Port.search @term, page: params[:page], per_page: 20
      #@es_ports = Port.all.paginate(page: params[:page])
  end

end
