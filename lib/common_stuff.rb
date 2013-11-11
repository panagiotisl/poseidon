module CommonStuff

  def authorized_sce
    unless current_user && ((current_user.shipping_company_id && current_user.shipping_company_id.to_s == params[:id]) || current_user.admin)
      flash[:error] = "You do not have permission to view this page!"
      redirect_to :back
    end
  end

  def authorized_ase
    p params
    unless current_user && ((current_user.agent_id && current_user.agent_id.to_s == params[:agent_id]) || current_user.admin)
      flash[:error] = "You do not have permission to view this page!"
      redirect_to :back
    end
  end
end
