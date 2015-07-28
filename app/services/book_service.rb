class BookService
  include HTTParty
  base_uri 'http://it-ebooks-api.info/v1'
  attr_accessor :query, :page, :total, :current_page

  def initialize()
    @current_page = 0
    @total = 0
  end

  def search(query = '', page = 1)
    begin
      books_response = self.class.get("/search/#{query}/page/#{page}")
      @total = JSON.parse(books_response.body)["Total"].to_i
      @current_page = JSON.parse(books_response.body)["Page"].to_i
      books_obj = JSON.parse(books_response.body)
      books = to_books(books_obj["Books"])
      books
    rescue Exception => e
      puts e.message
    end
  end

  def book(id)
    begin
      book_response = self.class.get("/book/#{id}")
      book = Book.new(JSON.parse(book_response.body))
      book
    rescue Exception => e
      puts e.message
    end

  end

  def has_next
     @current_page < (total%10 == 0 ? (total/10) : (total/10)+1)
  end


  def has_prev
    @current_page > 1
  end

  def to_books(books_json)
    books = []
    books_json.each do |book_json|
      book = Book.new(book_json)
      books.push(book)
    end
    books
  end

  def random_books
    prog =[
        "java","ruby","php","python",
        "c", "Servlets","c++", "rails",
        "c#",".net","jsp","jdbc"].sample(3)

    db = ["mysql","oracle","postgresql","mongodb"].sample(3)
    js = ["javascript","jquery","ajax"].sample(2)
    css = ["css","css3"].sample(2)

    prg_books = []
    db_books=[]
    js_books=[]
    css_books=[]

    prog.each_with_index do |prg, i|
      prg_books << search(prg, i)
    end

    db.each_with_index do |db1, i|
      db_books << search(db1, i)
    end

    js.each_with_index do |js1, i|
      js_books << search(js1, i)
    end

    css.each_with_index do |css1, i|
      css_books << search(css1, i)
    end

    prg_books.flatten!().compact!
    db_books.flatten!().compact!
    js_books.flatten!().compact!
    css_books.flatten!().compact!

    {prog: prg_books, db: db_books, js: js_books, css: css_books}

  end

end
