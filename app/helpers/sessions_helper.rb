module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token  = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def sce?
    current_user && current_user.shipping_company_id
  end

  def ase?
    current_user && current_user.agent_id
  end
    
  def authorized_sce
    @shipping_company_id = params[:shipping_company_id] || params[:id]
    unless current_user && ((current_user.shipping_company_id && current_user.shipping_company_id.to_s == @shipping_company_id) || current_user.admin)
      flash[:error] = "You do not have permission to view this page!"
      redirect_to :back
    end
  end

  def authorized_sce?
    @shipping_company_id = params[:shipping_company_id] || params[:id]
    current_user && (current_user.shipping_company_id && current_user.shipping_company_id.to_s == @shipping_company_id)
  end

  def authorized_ase
    @agent_id = params[:agent_id] || params[:id]
    unless current_user && ((current_user.agent_id && current_user.agent_id.to_s == @agent_id) || current_user.admin)
      flash[:error] = "You do not have permission to view this page!"
      redirect_to :back
    end
  end
  
  def authorized_ase?
    @agent_id = params[:agent_id] || params[:id]
    current_user && (current_user.agent_id && current_user.agent_id.to_s == @agent_id)
  end

  def get_actor
    if current_user.shipping_company_id
      @actor = current_user.shipping_company
    elsif current_user.agent_id
      @actor = current_user.agent
    else
      @actor = current_user  
    end
  end
  
  def get_mailbox
    @mailbox = get_actor.mailbox
  end
  
end
