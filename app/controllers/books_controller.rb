class BooksController < ApplicationController
  def index
    # Load all categories for use in the view
    @category = Category.all

    # Load all books
    @books = Book.all

    # Apply search filtering if search term is present
    if params[:search].present?
      search_term = "%#{params[:search].downcase}%"
      @books = @books.where("LOWER(book_name) LIKE ? OR LOWER(book_desc) LIKE ?", search_term, search_term)
    end

    # Apply category filtering if category_id is present
    if params[:category_id].present?
      category = Category.find(params[:category_id])
      @books = category.books
    end
    
    # Paginate the books
    @books = @books.page(params[:page]).per(12)
  end

  def show
    @book = Book.find(params[:id])
  end
end
