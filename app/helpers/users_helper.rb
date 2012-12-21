module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def avatar_for(user, size=nil)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, width: size, class: "gravatar")
  end
end