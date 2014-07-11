class MessagesController < ApplicationController

  #autocomplete :user, :name
  #autocomplete :agent, :name, :extra_data => [:email]
  #autocomplete :recipients, {:agent => [:name], :shipping_company => [:name]}

  before_filter :signed_in_user
  before_filter :get_actor, :get_mailbox, :get_box, :get_fleets
  def index
    redirect_to conversations_path(:box => @box)
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    if @message = Message.find_by_id(params[:id]) and @conversation = @message.conversation
      if @conversation.is_participant?(@actor)
        redirect_to conversation_path(@conversation, :box => @box, :anchor => "message_" + @message.id.to_s)
      return
      end
    end
    redirect_to conversations_path(:box => @box)
  end


  def recipients
    @recipients = Agent.order(:name).where("LOWER(name) like ?", "%#{params[:term].downcase}%")
    @recipients += ShippingCompany.order(:name).where("LOWER(name) like ?", "%#{params[:term].downcase}%")
    render json: @recipients.map(&:name)
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
=begin    
    if params[:type] and params[:recipient]
      if params[:type] == 'sc'
        @name = ShippingCompany.where(params[:recipient]).name
      elsif params[:type] == 'a'
        @name = Agent.find(params[:recipient]).name
      end
    end
    if params[:receiver].present?
      @recipient = Actor.find_by_slug(params[:receiver])
      return if @recipient.nil?
      @recipient = nil if Actor.normalize(@recipient)==Actor.normalize(current_subject)
    end
=end
    @name = params[:recipient]
  end

  # GET /messages/1/edit
  def edit

  end

  # POST /messages
  # POST /messages.xml
  def create
    
    @recipients = params[:message_recipient_name].split(',').map{ |r| Agent.where(name: r).first }
    puts @recipients
    if !@recipients.any?
      @recipients = params[:message_recipient_name].split(',').map{ |r| ShippingCompany.where(name: r).first }
    end
    @receipt = @actor.send_message(@recipients, params[:body], params[:subject])
    if (@receipt.errors.blank?)
      Sender.create(notification_id: @receipt.notification.id, user_id: current_user.id)
      @conversation = @receipt.conversation
      if params[:voyages_port]
        Label.create(conversation_id: @conversation.id, voyages_port_id: params[:voyages_port])
      end
      flash[:success]= t('mailboxer.sent')
      redirect_to conversation_path(@conversation, :box => :sentbox)
    else
      render :action => :new
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update

  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy

  end


  private

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      @box = "inbox"
    return
    end
    @box = params[:box]
  end

end