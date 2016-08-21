Rails.configuration.stripe = {
  :publishable_key => ENV['PLATFORM_PUBLISHABLE_KEY'],
  :secret_key      => ENV['PLATFORM_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
