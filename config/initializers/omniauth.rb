Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
  {
    scope: 'email, profile',
    image_aspect_ratio: 'square'
  }

  provider :discord, ENV['DISCORD_CLIENT_ID'], ENV['DISCORD_CLIENT_SECRET'], scope: 'email identify'

  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user"

  provider :line, ENV['LINE_CHANNNEL_ID'], ENV['LINE_CHANNEL_SECRET']
end
OmniAuth.config.allowed_request_methods = %i[get]