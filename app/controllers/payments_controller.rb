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
    @tax_rates = TaxRates.load_rates[@province_name]


    if @tax_rates.nil?
      flash.now[:error] = "Tax rates for your province are not found. Please contact support."
      return
    end

    p_order = Order.maximum(:id)
    c_order = p_order + 1

    book_id = @cart.keys.first


    @customer = Customer.create(user: @user, province: @province)
@book = Book.find(book_id)
        @order = Order.create(
          order_id: SecureRandom.uuid,
          book: @book, # Associate the order with an existing book record
          customer: @customer,
          user:@user.id,
          province: @province_id
        )

        if @order.errors.any?
          Rails.logger.error "Error creating order: #{@order.errors.full_messages}"
        end

    @book = Book.find(params[:book_id]) 
    current_user.customer 

    last_order_number = Order.maximum(:id) || 0
    next_order_number = last_order_number + 1
    
    @checkout_session = current_user.payment_processor.checkout(
      mode: "payment",
      line_items: [{
        price_data: {
          unit_amount: (@book.book_price * 100).to_i,
          currency: 'usd',
          product_data: {
            name: @book.book_name
          }
        },
        quantity: 1
      }],
      metadata: {
        order_id: c_order
      }
    )
  end


  private
  def calculate_total_price(cart)
    total_price = 0
    cart.each do |book_id, quantity|
      book = Book.find(book_id)
      total_price += book.book_price * quantity
    end
    total_price
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
