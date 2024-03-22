class BooksController < ApplicationController
  def index
    @books = Book.all
    search_term = params[:search].downcase if params[:search].present?
    @books = @books.where("book_name LIKE ?", "%#{params[:search]}%") if search_term.present? 
    @books = @books.page(params[:page]).per(10)
  end
end
