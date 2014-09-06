class PagesController < ApplicationController

  before_filter :get_fleets

  
  def new
    @title = "Create a page"
    @page = Page.new
  end
  
  def create
    @page = Page.new(page_params)
    @page.content = 'No content yet'
    if @page.save
      flash[:success] = "Page created!"
      redirect_to shipping_company_path(:id => params[:shipping_company_id], :page_id => @page.id)
    else
      render 'new'
    end

  end
  
  def sort
    @page = Page.find(params[:id])

    # .attributes is a useful shorthand for mass-assigning
    # values via a hash
    @page.update_attributes(params[:page].permit(:position_position))
    #@page.attributes = params[:page], permit[:position_attribute]
    @page.save

    # this action will be called via ajax
    render nothing: true
  end

  private
  
    def page_params
      params.require(:page).permit(:name, :shipping_company_id)
    end

end
