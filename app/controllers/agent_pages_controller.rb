class AgentPagesController < ApplicationController

  before_filter :get_fleets

  
  def new
    @title = "Create a page"
    @page = AgentPage.new
  end
  
  def create
    @page = AgentPage.new(agent_page_params)
    @page.content = 'No content yet'
    if @page.save
      flash[:success] = "Page created!"
      redirect_to agent_path(:id => params[:agent_id], :page_id => @page.id)
    else
      render 'new'
    end

  end
  
  def sort
    @page = AgentPage.find(params[:id])

    # .attributes is a useful shorthand for mass-assigning
    # values via a hash
    @page.update_attributes(params[:page].permit(:position_position))
    #@page.attributes = params[:page], permit[:position_attribute]
    @page.save

    # this action will be called via ajax
    render nothing: true
  end

  private
  
    def agent_page_params
      params.require(:agent_page).permit(:name, :agent_id)
    end

end
