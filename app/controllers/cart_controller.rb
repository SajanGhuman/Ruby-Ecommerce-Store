class CartController < ApplicationController
  
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

  def update_province
    @cart = session[:cart] || {}
    
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Province updated successfully."
      session[:cart] = @cart
    else
      flash[:error] = "Failed to update province."
    end
    redirect_to invoice_path
  end
  
  
 def user_params
    params.require(:user).permit(:province_id)
  end 

  def invoice
    if current_user
      @user = current_user
      @cart = session[:cart] || {}
      @total_price = calculate_total_price(@cart)
      @province_id = @user.province_id
      @province_name = Province.find(@province_id).name
      @tax_rates = TaxRates.load_rates[@province_name]
      @book = Book.find(@cart.keys.first) unless @cart.empty?

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
    else
      flash.now[:error] = "You must be logged in to view the invoice."
    end
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
end
