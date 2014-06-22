class StaticPagesController < ApplicationController

  def home
    if signed_in?
      if sce?
        @fleets = current_user.shipping_company.fleets.paginate(page: params[:page])
        @ships = current_user.shipping_company.ships.paginate(page: params[:page])
        @voyages = current_user.shipping_company.voyages.paginate(page: params[:page])
      elsif ase?
        @fleets = Fleet.none
        @voyages_ports = current_user.agent.voyages_ports.paginate(page: params[:page])
      end
    end
  end
  
  def help
  end

  def about
  end

  def contact
  end
end
