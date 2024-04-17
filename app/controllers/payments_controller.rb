class PaymentsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
  end

  def show
    @user = current_user
    @cart = session[:cart] || {}
    @total_price = calculate_total_price(@cart)
    @province_id = @user.province_id
    @province = Province.find(@province_id)
    @province_name = @province.name
    puts "@province_name: #{@province_name}"


    if @tax_rates.nil?
      flash.now[:error] = "Tax rates for your province are not found. Please contact support."
      return
    end

    session[:order_ids] ||= []

    @customer = Customer.create(user: @user, province: @province)

    @cart.each do |book_id, quantity|
      book = Book.find(book_id)
      @order = @customer.orders.create(
        order_id: SecureRandom.uuid,
        book: book,
        user: @user.id,
        province: @province_id,
        status: "pending",
        shipping_status: "pending"
      )
  
      session[:order_ids] << @order.id
  
      if @order.errors.any?
        Rails.logger.error "Error creating order: #{@order.errors.full_messages}"
      end
    end

    last_order_number = Order.maximum(:id) || 0
    next_order_number = last_order_number + 1


    total_price = 0
    line_items = []
    @cart.each do |book_id, quantity|
      book = Book.find(book_id)
      unit_amount = (book.book_price * 100).to_i
      total_price += unit_amount * quantity
      line_items << {
        price_data: {
          unit_amount: unit_amount,
          currency: 'usd',
          product_data: {
            name: book.book_name
          }
        },
        quantity: quantity,
        metadata: { book_id: book_id }
      } 
    end

    total_price = calculate_total_price(@cart)
  
    @checkout_session = current_user.payment_processor.checkout(
      mode: "payment",
      line_items: line_items,
      payment_intent_data: {
      amount: total_price,
      currency: 'cad'
    }  
    )
  end

  private
  def calculate_total_price(cart)
    total_price = 0
  
    cart.each do |book_id, quantity|
      book = Book.find(book_id)
      total_price += (book.book_price * tax_rate_for_province()) * quantity
    end
    total_price
  end

  def tax_rate_for_province()
    total_tax_rate = @tax_rates.values.sum
    total_tax_rate
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