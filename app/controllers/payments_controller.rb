class PaymentsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
  end

  def show
    @user = current_user
    @cart = session[:cart] || {}
    @province_id = @user.province_id
    @province = Province.find(@province_id)
    @province_name = @province.name
    @tax_rates = TaxRates.load_rates[@province_name]

    if @tax_rates.nil?
      flash.now[:error] = "Tax rates for your province are not found. Please contact support."
      return
    end

    session[:order_ids] ||= []
    @customer = @user.customer || @user.create_customer(province: @province)

    @user.update(customer_id: @customer.id) if @user.present?

    @cart.each do |book_id, quantity|
      book = Book.find(book_id)

      order = Order.create(
        order_id:        SecureRandom.uuid,
        book:,
        customer_id:     @customer.id,
        user:            @user.id,
        province:        @province_id,
        status:          "pending",
        payment_id:      "TBD",
        shipping_status: "pending"
      )

      if order.errors.any?
        Rails.logger.error "Error creating order: #{order.errors.full_messages}"
      else
        session[:order_ids] << order.id
      end
    end

    line_items = []
    order_ids = session[:order_ids]
    @cart.each do |book_id, quantity|
      book = Book.find(book_id)
      line_items << {
        price_data: {
          unit_amount:  (book.book_price * 100).to_i,
          currency:     "usd",
          product_data: {
            name: book.book_name
          }
        },
        quantity:
      }
    end

    order_ids = session[:order_ids] || []

    order_ids_string = order_ids.join(",")

    @checkout_session = current_user.payment_processor.checkout(
      mode:       "payment",
      line_items:,
      metadata:   { order_ids: order_ids_string }
    )
  end

  def success
    flash[:success] = "Payment successful. Thank you for your purchase!"
    redirect_to root_path
  end

  def cancel
    flash[:error] = "Payment cancelled."
    redirect_to root_path
  end
end
