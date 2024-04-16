class CartController < ApplicationController
  TAX_RATE = 0.1
  def add_to_cart
    book = Book.find(params[:id])
    session[:cart] ||= {}
    session[:cart][book.id] ||= 0
    session[:cart][book.id] += 1

    redirect_to show_cart_path, notice: 'Book added to cart successfully.'
  end

  def show_cart
    @cart = session[:cart] || {}
  end

  def remove_from_cart
    book_id = params[:book_id].to_i
    session[:cart].delete(book_id) if session[:cart].key?(book_id)

    redirect_to show_cart_path, notice: 'Book removed from cart successfully.'
  end

  def checkout
    @cart = session[:cart] || {}
    @total_price = calculate_total_price(@cart)
    @province_id = current_user.province_id
    @tax_rates = TaxRates.load_rates[@province]


    if @tax_rates.nil?
      flash.now[:error] = "Tax rates for your province are not found. Please contact support."
      return
    end

    @pst_rate = @tax_rates['pst']
    @gst_rate = @tax_rates['gst']
    @hst_rate = @tax_rates['hst']
    @pst_amount = @total_price * @pst_rate
    @gst_amount = @total_price * @gst_rate
    @hst_amount = @total_price * @hst_rate
    @total_with_taxes = @total_price + @pst_amount + @gst_amount + @hst_amount
  end

  def calculate_total_price(cart)
    total_price = 0
    cart.each do |book_id, quantity|
      book = Book.find(book_id)
      total_price += book.book_price * quantity
    end
    total_price
  end
end
