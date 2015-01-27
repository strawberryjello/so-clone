# might work better as a helper class
module Mentionable

  def parse_mentions source
    parsed = source
    source.scan(/(@)([\w.-]{3,40})/i) do |match|
      # TODO: how do you decouple this?
      user = User.find_by(:login => match[1])
      if user
        profile_link = create_link user.profile_url, match[1]
        parsed = parsed.sub(match[0] + match[1], profile_link)
      end
    end
    parsed
  end


  private

  def create_link href, body
    "<a href='#{href}'>#{body}</a>"
  end
end
