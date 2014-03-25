class NotificationsController < ApplicationController
  
  before_filter :signed_in_user
  before_filter :get_actor, :get_mailbox
  
  def show
    @notification = Notification.find(params[:id])
    @receipts = @mailbox.receipts_for(@notification).not_trash
    @receipts.mark_as_read
    # create a mark for every reader
    #@receipts.each do |receipt|
    #  if (receipt.mailbox_type == "") and ((receipt.receiver_type == "Agent" and current_user.agent_id == receipt.receiver_id) or (receipt.receiver_type == "ShippingCompany" and current_user.shipping_company_id == receipt.receiver_id))
    #    Reader.create(user_id: current_user.id, notification_id: receipt.notification.id)
    #  end
    #end
    Reader.create(user_id: current_user.id, notification_id: @notification.id)
    render :action => :show    
  end
  
end
