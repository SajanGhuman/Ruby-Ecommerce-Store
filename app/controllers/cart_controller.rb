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
end
