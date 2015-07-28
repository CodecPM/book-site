class BookService::BooksController < ApplicationController
layout 'books'

  def show
    book_service = BookService.new
    @book = book_service.book(params[:id].to_i)
  end

  def index
    book_service = BookService.new
    random_books = book_service.random_books

    @prg_books = random_books[:prog]
    @db_books = random_books[:db]
    @js_books = random_books[:js]
    @css_books = random_books[:css]
  end

  def search
    query = params[:query]
    page = params[:page] if params[:page].present?
    book_service = BookService.new
    @books = book_service.search(query, page)
    @has_prev = book_service.has_prev
    @has_next = book_service.has_next
    @current_page = book_service.current_page
    @query = query
  end

end
