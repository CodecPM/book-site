class Book
  attr_accessor :error, :id, :time, :title, :sub_title, :description, :author, :isbn, :pages, :year,
                :publisher, :image, :download_link

  def initialize(book)
    @error = book["Error"]
    @id = book["ID"]
    @time = book["Time"]
    @title = book["Title"]
    @sub_title = book["SubTitle"]
    @description = book["Description"]
    @author = book["Author"]
    @isbn = book["isbn"] || book["ISBN"]
    @pages = book["Page"]
    @year = book["Year"]
    @publisher = book["Publisher"]
    @image = book["Image"]
    @download_link = book["Download"]
  end

end
