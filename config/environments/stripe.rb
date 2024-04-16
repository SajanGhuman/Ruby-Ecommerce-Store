Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_51P653TRsxxc3eVDFtvIEPyRAK8JrxMl56r51h6CQ0pAh0QtTNfWaZoNRbTXOammZeehqCukF8iAVIW9NpTuQyf3P00jgu8fPCq'],
  secret_key: ENV['sk_test_51P653TRsxxc3eVDFw44WUDZxFoIUgpfKAh6yAmqpNjwIQlWIC8HouXCg6IPHt7QeWoD9DwgsEqHHJuzqoUnysobC00Wxc19Lz8']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
