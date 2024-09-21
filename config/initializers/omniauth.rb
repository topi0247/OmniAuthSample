Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
  {
    scope: 'email, profile',
    image_aspect_ratio: 'square'
  }

  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']

  provider :discord, ENV['DISCORD_CLIENT_ID'], ENV['DISCORD_CLIENT_SECRET'], scope: 'email identify'

  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user"

  provider :line, ENV['LINE_CHANNNEL_ID'], ENV['LINE_CHANNEL_SECRET']

  provider :apple, ENV['APPLE_CLIENT_ID'], '', {
    scope: 'email name',
    team_id: ENV['APPLE_TEAM_ID'],
    key_id: ENV['APPLE_KEY_ID'],
    pem: ENV['APPLE_PRIVATE_KEY']
  }

  provider :yahoojp, ENV['YAHOOJP_KEY'], ENV['YAHOOJP_SECRET'], scope: "openid profile email address"
end
OmniAuth.config.allowed_request_methods = %i[get]