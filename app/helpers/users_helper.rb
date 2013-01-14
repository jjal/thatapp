module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def avatar_for(avatar_num, size=nil)
    #gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    #gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    #image_tag("#{user.avatar}.png", alt: user.name, width: size, class: "avatar")
    content_tag("div", "", class: "avatar avatar#{avatar_num}");
  end
end