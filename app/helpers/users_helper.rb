module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  def works_for(user)
    if user.kind_of? AUser then
      a = Agent.find(user.agent_id)
      link_to a.name, a
    elsif user.kind_of? SCUser then
      sc = ShippingCompany.find(user.shipping_company_id)
      link_to sc.name, sc
    end
  end

  def name_works_for(user)
    if user.kind_of? AUser then
      Agent.find(user.agent_id).name
    elsif user.kind_of? SCUser then
      ShippingCompany.find(user.shipping_company_id).name
    end
  end


end
