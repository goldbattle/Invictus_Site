module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 , style: "" })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&r=g&d=identicon"
    image_tag(gravatar_url, alt: user.username, class: "gravatar", style: options[:style])
  end

  def findUserById(user_id)
    user = User.find_by_id(user_id)
    if(user == nil)
      # Create a new user
      user = User.new(username: "Removed User", email: "deleted@invictus.com", admin: false)
    end
    # Return the user
    user
  end
end
