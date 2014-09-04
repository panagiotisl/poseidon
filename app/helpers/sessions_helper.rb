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
    @sce ||= current_user && current_user.shipping_company_id
  end

  def ase?
    @ase ||= current_user && current_user.agent_id
  end
  
  def get_company_id
    if sce?
      @company_id ||= current_user.shipping_company_id
    elsif ase?
      @company_id ||= current_user.agent_id
    else
      @company_id ||= nil
    end
  end
  
  def get_company_type
    if sce?
      @company_type ||= "ShippingCompany"
    elsif ase?
      @company_type ||= "Agent"
    else
      @company_type ||= nil
    end
  end
    
  def authorized_sce
    @shipping_company_id = params[:shipping_company_id] || params[:id]
    unless current_user && ((current_user.shipping_company_id && current_user.shipping_company_id.to_s == @shipping_company_id) || current_user.admin)
      flash[:error] = "You do not have permission to view this page!"
      redirect_to :back
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
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
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
  
  def authorized_ase?
    @agent_id = params[:agent_id] || params[:id]
    current_user && (current_user.agent_id && current_user.agent_id.to_s == @agent_id)
  end

  def get_actor
    if current_user.shipping_company_id
      @actor ||= current_user.shipping_company
    elsif current_user.agent_id
      @actor ||= current_user.agent
    else
      @actor = current_user  
    end
  end
  
  def get_mailbox
    @mailbox = get_actor.mailbox
  end
  
  def get_inbox
    get_actor.mailbox.inbox  
  end
  
  def get_latest_notifications
    Notification.order('created_at DESC').where("id IN (SELECT notification_id FROM receipts where receiver_id=:receiver_id and receiver_type=:receiver_type order by created_at desc limit 10)", receiver_id: get_company_id, receiver_type: get_company_type)
  end
  
  def get_unread(receipts)
    notifications = []
    receipts.each do |receipt|
      # nil for notifications
      if receipt.mailbox_type == "inbox" || receipt.mailbox_type.nil?
        notifications << receipt.notification.id
      end
    end
    @unread = notifications.count - Reader.where(:notification_id => notifications).count
    #if @unread > 0
    #  @unread.to_s
    #else
    #  ""
    #end
    @unread.to_s
  end
  
  def is_readC(conversation)
    Reader.where(:conversation_id => conversation.id, :user_id => current_user.id).count > 0
  end
  
    def is_readN(notification)
    Reader.where(:notification_id => notification.id, :user_id => current_user.id).count > 0
  end
  
  def get_fleets
    if(sce?)
      @fleets = current_user.shipping_company.fleets
    else
      @fleets = Fleet.none
    end
  end
  
  def getSender(receiver_id, receiver_type)
    if receiver_type == "ShippingCompany"
      ShippingCompany.find(receiver_id)
    else
      Agent.find(receiver_id)
    end
  end
  
end
