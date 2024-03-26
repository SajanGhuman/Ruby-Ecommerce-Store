class BooksController < ApplicationController
  def index
    # Load all categories for use in the view
    @category = Category.all

    # Load all books
    @books = Book.all

    @cart = session[:cart] || {}

    # Apply additional filters
    if params[:filter].present?
      filters = params[:filter].split(',')
      filters.each do |filter|
        case filter
        when "on_sale"
          @books = @books.where(on_sale: true)
        when "new"
          @books = @books.where("created_at >= ?", 3.days.ago)
        when "recently_updated"
          recently_updated_books = @books.where("updated_at >= ?", 3.days.ago)
          new_books = @books.where("created_at >= ?", 3.days.ago)
          @books = recently_updated_books.where.not(id: new_books.pluck(:id))
        end
      end
    end

    # Apply search filtering if search term is present
    if params[:search].present?
      search_term = "%#{params[:search].downcase}%"
      @books = @books.where("LOWER(book_name) LIKE ? OR LOWER(book_desc) LIKE ?", search_term, search_term)
    end

    # Paginate the books
    @books = @books.page(params[:page]).per(12)
  end


  def show
    @book = Book.find(params[:id])
  end

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

  def remove_item_from_cart
    book_id = params[:id]
    session[:cart].delete(book_id)
    redirect_to show_cart_path, notice: 'Item removed from cart successfully.'
  end

  def increase_quantity
    book_id = params[:id]
    session[:cart][book_id] += 1 if session[:cart][book_id]
    redirect_to show_cart_path, notice: 'Quantity increased successfully.'
  end

  def decrease_quantity
    book_id = params[:id]
    session[:cart][book_id] -= 1 if session[:cart][book_id] && session[:cart][book_id] > 0
    session[:cart].delete(book_id) if session[:cart][book_id] == 0
    redirect_to show_cart_path, notice: 'Quantity decreased successfully.'
  end 
end
