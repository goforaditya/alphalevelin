Rails.application.config.middleware.use OmniAuth::Builder do
  # Add the providers you want to support
  # You should set up environment variables for these in production
  # For GitHub
  provider :github, ENV['GITHUB_KEY'] || 'github_dev_key_123456', ENV['GITHUB_SECRET'] || 'github_dev_secret_abcdef123456', scope: 'user:email'
  
  # For Google
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'] || '123456789-dev-client-id.apps.googleusercontent.com', ENV['GOOGLE_CLIENT_SECRET'] || 'google_dev_secret_abcdef123456'
end

# Protect from CSRF
OmniAuth.config.allowed_request_methods = [:post]
OmniAuth.config.silence_get_warning = true