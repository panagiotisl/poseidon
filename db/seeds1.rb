def time_rand from = 2.year.ago, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

(1..50).each do |i|
  time = time_rand
  a = Notification.notify_all(ShippingCompany.find(1), "Test Notification #{i}", "Just a test notification")
  a.created_at = time
  a.updated_at = time
  b = a.notification
  b.created_at = time
  b.updated_at = time
  a.save
  b.save
end

