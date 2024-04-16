class StripeWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def handle_event
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.configuration.stripe[:signing_secret]
      )
    rescue JSON::ParserError => e
      render json: { error: e.message }, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      render json: { error: e.message }, status: :bad_request
      return
    end

    case event.type
    when 'checkout.session.completed'
      handle_checkout_session_completed(event)
    when 'payment_intent.succeeded'
      handle_payment_intent_succeeded(event)
    else
      render json: { status: 'ignored' }
    end
  end

  private

  def handle_checkout_session_completed(event)
    session = event.data.object
    order_id = session.metadata.order_id

    if order_id
      order = Order.find_by(id: order_id)

      if order
        order.update(status: 'paid')
        render json: { status: 'success' }
      else
        render json: { error: "Order not found for ID: #{order_id}" }, status: :not_found
      end
    else
      render json: { error: "No order ID found in metadata" }, status: :bad_request
    end
  end

  def handle_payment_intent_succeeded(event)
    payment_intent_id = event.data.object.id
    order_id = Order.last
  
    if order_id
      order = Order.find_by(id: order_id)
  
      if order
        order.update(payment_id: payment_intent_id)
        render json: { status: 'success' }
      else
        render json: { error: "Order not found for ID: #{order_id}" }, status: :not_found
      end
    else
      render json: { error: "No order ID found in metadata" }, status: :bad_request
    end
  end  
end
