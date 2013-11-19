module CommonStuff

  def authorized_sce
    @shipping_company_id = params[:shipping_company_id] || params[:id]
    unless current_user && ((current_user.shipping_company_id && current_user.shipping_company_id.to_s == @shipping_company_id) || current_user.admin)
      flash[:error] = "You do not have permission to view this page!"
      redirect_to :back
    end
  end

  def authorized_ase
    @agent_id = params[:agent_id] || params[:id]
    unless current_user && ((current_user.agent_id && current_user.agent_id.to_s == @agent_id) || current_user.admin)
      flash[:error] = "You do not have permission to view this page!"
      redirect_to :back
    end
  end
end
