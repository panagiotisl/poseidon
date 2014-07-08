class ConversationsController < ApplicationController
  before_filter :signed_in_user
  before_filter :get_actor, :get_mailbox, :get_box
  before_filter :check_current_subject_in_conversation, :only => [:show, :show_small, :update, :update_small, :destroy]

  def index
    if params[:voyages_port]
      @conversations = @mailbox.inbox.where("conversation_id IN (#{labeled_by_vp})", voyages_port_id: params[:voyages_port]).page(params[:page])
    elsif @box.eql? "inbox"
      @conversations = @mailbox.inbox.page(params[:page])#.per(9)
      @notifications = @mailbox.notifications.page(params[:page])#.per(9)
      @conversations += @notifications
      @conversations.sort! { |a,b| a.updated_at <=> b.updated_at }
    elsif @box.eql? "sentbox"
      @conversations = @mailbox.sentbox.page(params[:page])#.per(9)
    else
      @conversations = @mailbox.trash.page(params[:page])#.per(9)
    end
    respond_to do |format|
      format.html { render @conversations if request.xhr? }
    end
  end

  def show
    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    render :action => :show
    @receipts.mark_as_read
    Reader.create(user_id: current_user.id, conversation_id: @conversation.id)
    @receipts.each do |receipt|
      if (receipt.mailbox_type == "inbox") and ((receipt.receiver_type == "Agent" and current_user.agent_id == receipt.receiver_id) or (receipt.receiver_type == "ShippingCompany" and current_user.shipping_company_id == receipt.receiver_id))
        Reader.create(user_id: current_user.id, notification_id: receipt.notification.id)
      end
    end
  end

  def update
    if params[:untrash].present?
    @conversation.untrash(@actor)
    end

    if params[:reply_all].present?
      last_receipt = @mailbox.receipts_for(@conversation).last
      @receipt = @actor.reply_to_all(last_receipt, params[:body])
      Sender.create(notification_id: @receipt.notification.id, user_id: current_user.id)
    end

    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    redirect_to :action => :show
    @receipts.mark_as_read

  end

  def destroy

    @conversation.move_to_trash(@actor)

    respond_to do |format|
      format.html {
        if params[:location].present? and params[:location] == 'conversation'
          redirect_to conversations_path(:box => :trash)
        else
          redirect_to conversations_path(:box => @box,:page => params[:page])
        end
      }
      format.js {
        if params[:location].present? and params[:location] == 'conversation'
          render :js => "window.location = '#{conversations_path(:box => @box,:page => params[:page])}';"
        else
          render 'conversations/destroy'
        end
      }
    end
  end

  def show_small
    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    render :layout => false
    @receipts.mark_as_read
    Reader.create(user_id: current_user.id, conversation_id: @conversation.id)
    @receipts.each do |receipt|
      if (receipt.mailbox_type == "inbox") and ((receipt.receiver_type == "Agent" and current_user.agent_id == receipt.receiver_id) or (receipt.receiver_type == "ShippingCompany" and current_user.shipping_company_id == receipt.receiver_id))
        Reader.create(user_id: current_user.id, notification_id: receipt.notification.id)
      end
    end
  end

  def update_small
    if params[:untrash].present?
    @conversation.untrash(@actor)
    end
    if params[:reply_all].present?
      last_receipt = @mailbox.receipts_for(@conversation).last
      @receipt = @actor.reply_to_all(last_receipt, params[:body])
      Sender.create(notification_id: @receipt.notification.id, user_id: current_user.id)
    end
    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    @receipts.mark_as_read
  end

  def refresh_latest
    respond_to do |format|
      format.js
    end
  end


  def refresh_feed
    respond_to do |format|
      format.js
    end
  end

  private

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      params[:box] = 'inbox'
    end

    @box = params[:box]
  end

  def check_current_subject_in_conversation
    @conversation = Conversation.find_by_id(params[:id])

    if @conversation.nil? or !@conversation.is_participant?(@actor)
      redirect_to conversations_path(:box => @box)
    return
    end
  end

  private

    def labeled_by_vp()
      clause = "SELECT conversation_id FROM labels WHERE voyages_port_id = :voyages_port_id"
    end

end