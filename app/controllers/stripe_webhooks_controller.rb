class StripeWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def handle_event
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
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
    when "checkout.session.completed"
      handle_checkout_session_completed(event)
    else
      render json: { status: "ignored" }
    end
  end

  def handle_checkout_session_completed(event)
    payment_intent = event.data.object
    order_ids = payment_intent.metadata.order_ids

    if order_ids.present?
      ids_array = order_ids.split(",")
      orders = Order.where(id: ids_array)

      orders.each do |order|
        order.update(payment_id: payment_intent.id, status: "paid")
      end

      render json: { status: "success" }
    else
      render json: { error: "No order IDs found in metadata" }, status: :bad_request
    end
  end
end
