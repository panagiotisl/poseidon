class AffiliationsController < ApplicationController

  before_action :admin_user,     only: [:index, :show, :new, :create]

  def index
    @affiliations = Affiliation.paginate(page: params[:page])
  end
  
  def show
    @affiliation = Affiliation.find(params[:id])
  end

  def new
    @affiliation = Affiliation.new
  end

  def create
    @affiliation = Affiliation.new(affiliation_params)
    if @affiliation.save
      flash[:success] = "Affiliation Saved!"
      redirect_to @affiliation
    else
      render 'new'
    end
  end

  def destroy
    Affiliation.find(params[:id]).destroy
    flash[:success] = "Affiliation destroyed."
    redirect_to affiliations_url
  end


  private
  
    def affiliation_params
      params.require(:affiliation).permit(:name, :category_id)
    end
    
    def admin_user
      unless current_user && current_user.admin?
        flash[:error] = "You do not have permission to view this page!"
        redirect_to(root_url)
      end
         
    end    

end
