Receipt.class_eval do
  
  searchkick
  
  def search_data
    {
      body: getNotification.body,
      subject: getNotification.subject,
      mailbox_type: mailbox_type,
      receiver: getReceiverName(receiver_id, receiver_type),
      receiver_id: receiver_id,
      receiver_type: receiver_type,
      conversation_id: getNotification.conversation_id,
      created_at: created_at
    }
  end
  
  private
  
    def getNotification
      @notification ||= Notification.find(notification_id)
    end
  
    def getReceiverName(receiver_id, receiver_type)
      if (receiver_type)
        if (receiver_type == "Agent")
          Agent.find(receiver_id).name
        elsif (receiver_type == "ShippingCompany")
          ShippingCompany.find(receiver_id).name
        end
      else
        "System"
      end
    end
end