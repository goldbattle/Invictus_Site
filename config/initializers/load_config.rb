# Load in the config file
APP_CONFIG = YAML.load_file(Rails.root+"config/config.yml")[Rails.env]

# Configure Email
if Rails.env != 'test'
  InvictusSiteV2::Application.configure do
    config.action_mailer.delivery_method = :smtp
    # Configure from the yaml
    config.action_mailer.smtp_settings = {
      :address   => APP_CONFIG['email']['address'],
      :port      => APP_CONFIG['email']['port'],
      :enable_starttls_auto => true,
      :user_name => APP_CONFIG['email']['user_name'],
      :password  => APP_CONFIG['email']['password'],
      :authentication => APP_CONFIG['email']['authentication'],
      :domain => APP_CONFIG['email']['domain'],
    }
  end
end