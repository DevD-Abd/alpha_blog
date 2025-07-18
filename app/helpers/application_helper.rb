module ApplicationHelper
    def gravatar_for(user, options = { size: 80 })
      email_hash = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      image_tag("https://www.gravatar.com/avatar/#{email_hash}?s=#{size}", alt: user.username, class: "gravatar rounded-circle", style: "width: #{size}px; height: #{size}px;")
    end
end
