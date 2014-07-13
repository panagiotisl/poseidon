class NotificationsController < ApplicationController
  
  before_filter :signed_in_user
  before_filter :get_actor, :get_mailbox
  before_action :get_fleets,     only: [:index, :show]

  def index
    @notifications = @mailbox.notifications.page(params[:page])#.per(9)
    respond_to do |format|
      format.html { render @notifications if request.xhr? }
    end
  end
  
  
  def show
    @notification = Notification.find(params[:id])
    @receipts = @mailbox.receipts_for(@notification).not_trash
    @receipts.mark_as_read
    Reader.create(user_id: current_user.id, notification_id: @notification.id)
    render :action => :show    
  end
  
end
