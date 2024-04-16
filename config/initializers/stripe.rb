Rails.configuration.stripe = {
  secret_key: ENV['STRIPE_SECRET_KEY'],
  signing_secret: ENV['STRIPE_SIGNING_SECRET'],
  public_key: ENV['STRIPE_PUBLIC_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
StripeEvent.signing_secret = Rails.configuration.stripe[:signing_secret]

StripeEvent.configure do |events|
  events.subscribe 'checkout.session.completed' do |event|
    begin
      order_number = event.data.object.metadata.order_id
      payment_id = event.data.object.payment_intent

      Rails.logger.info "Received checkout.session.completed event for order ID: #{order_number}, payment ID: #{payment_id}"

      order = Order.find_by(id: order_number)
      
      if order
        ActiveRecord::Base.transaction do
          order.update!(status: 'paid', payment_id: payment_id)
          Rails.logger.info "Order #{order_number} updated to paid status with payment ID: #{payment_id}"
        end
      else
        Rails.logger.error "Order not found for order number: #{order_number}"
      end
    rescue StandardError => e
      Rails.logger.error "Error processing checkout.session.completed event: #{e.message}"
    end
  end
end
