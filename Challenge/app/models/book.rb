class Book 
  include ActiveModel::Model
  validates_presence_of :title, :author, :publication_year

  attr_accessor :id, :title, :author, :publication_year
  @@books = []
  @@next_id = 0

  def initialize(params)
    @id = Book.get_next_id
    @title = params[:title]
    @author = params[:author]
    @publication_year = params[:publication_year]
  end

  def as_json(*args)
    {
      id: id,
      title: title,
      author: author,
      publication_year: publication_year
    }
  end

  def destroy!
    @@books.delete(self)
  end

  class << self
    def find_all
      @@books
    end

    def create(book_params)
      book = Book.new(book_params)
      raise 'Validation Error' unless book.valid?
      @@books.push(book)
      book
    end

    def find_by_id(id)
      results = @@books.filter { |x| x.id == id }
      raise 'Not Found' unless results.one?
      results.first
    end

    def get_next_id
      @@next_id += 1
    end
  end
end