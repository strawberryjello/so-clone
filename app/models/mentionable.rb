# might work better as a helper class
module Mentionable

  def parse_mentions source
    parsed = source
    source.scan(/@([\w.-]{3,40})\b/i) do |match|
      # TODO: how do you decouple this?
      user = User.find_by(:login => match)
      if user
        profile_link = create_link user.profile_url, match[0]
        parsed = source.sub(match[0], profile_link)
      end
    end
    parsed
  end


  private

  def create_link href, body
    "<a href='#{href}'>#{body}</a>"
  end
end
