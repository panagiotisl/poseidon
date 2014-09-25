class AgentsController < ApplicationController

#  before_action :admin_user,     only: [:index, :show, :new, :create]
  before_filter :signed_in_user,     only: [:index, :show]
  before_filter :admin_user,     only: [:destroy]
  before_filter :authorized_ase,     only: [:manage_ports]
  before_action :get_fleets,     only: [:index, :show, :manage_ports]

  def index
    @agents = Agent.reorder("name ASC").paginate(page: params[:page])
  end
  
  def show
    @agent = Agent.find(params[:id])
    if params[:page_id]
      @page = @agent.agent_pages.find(params[:page_id])
    else
      @page = @agent.agent_pages.first
    end
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new(agent_params)
    if verify_recaptcha(@agent) && @agent.save
      flash[:success] = "Agent/Supplier Saved!"
      redirect_to @agent
    else
      render 'new'
    end
  end

  def destroy
    Agent.find(params[:id]).destroy
    flash[:success] = "Agent/Supplier destroyed."
    redirect_to agents_url
  end

  def manage_ports
    @agent = Agent.find(params[:id])
    @fleets = Fleet.none
    @title = "Manage ports"
    @ports_r = @agent.ports.paginate(page: params[:page])
    @ports_ur = (Port.all - @ports_r).paginate(page: params[:page])
  end

  def mercury_update
    page = AgentPage.find(params[:page_id])
    page.name = params[:content][:page_name][:value]
    page.content = params[:content][:page_content][:value]
    page.save!
    render text: ""
  end

  private
  
    def agent_params
      params.require(:agent).permit(:name, :email, :address, :telephone, :country_id)
    end
    
    def admin_user
      unless current_user && current_user.admin?
        flash[:error] = "You do not have permission to view this page!"
        redirect_to(root_url)
      end
    end

end
