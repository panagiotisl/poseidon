Receipt.class_eval do
  
  searchkick
  
  def search_data
    {
      id: id,
      subject: getNotification.subject,
      body: getNotification.body,
      mailbox_type: mailbox_type,
      receiver: getReceiverName(receiver_id, receiver_type),
      receiver_id: receiver_id,
      receiver_type: receiver_type,
      sender_id: getNotification.sender_id,
      sender_type: getNotification.sender_type,
      notification_id: getNotification.id,
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