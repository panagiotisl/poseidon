class AgentsController < ApplicationController

#  before_action :admin_user,     only: [:index, :show, :new, :create]
  before_action :admin_user,     only: [:destroy]

  def index
    @agents = Agent.reorder("name ASC").paginate(page: params[:page])
  end
  
  def show
    @agent = Agent.find(params[:id])
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
    @title = "Manage ports"
    @ports_r = @agent.ports.paginate(page: params[:page])
    @ports_ur = (Port.all - @ports_r).paginate(page: params[:page])
    p @ports_r.class.name
    p @ports_ur.class.name
    render 'manage_ports'
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
