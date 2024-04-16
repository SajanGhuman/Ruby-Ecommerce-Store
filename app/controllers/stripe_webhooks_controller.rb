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
        # Invalid payload
        render json: { error: e.message }, status: :bad_request
        return
      rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        render json: { error: e.message }, status: :bad_request
        return
      end
  
      # Handle the event
      case event.type
      when 'payment_intent.succeeded'
        handle_payment_succeeded(event)
      when 'payment_intent.failed'
        handle_payment_failed(event)
      # Add more event types as needed
      else
        # Unknown event type
        render json: { status: 'ignored' }
      end
    end
  
    private
  
    def handle_payment_succeeded(event)
      # Extract payment and order information from the event
      payment_intent_id = event.data.object.id
      order_id = event.data.object.metadata.order_id
  
      # Update the order status to indicate that it's paid
      order = Order.find_by(id: order_id)
      if order
        order.update(status: 'paid', payment_intent_id: payment_intent_id)
        render json: { status: 'success' }
      else
        render json: { error: "Order not found for ID: #{order_id}" }, status: :not_found
      end
    end
  
    def handle_payment_failed(event)
      # Handle payment failure event
    end
  end
  