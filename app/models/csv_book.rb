require 'csv'

# This class represent the main business object the csv file containing books

class CsvBook < ApplicationRecord
  validates :uuid, uniqueness: true
  attr_accessor :path
  has_many :books
  belongs_to :user

  def custom_build
    list_of_books = []
    CSV.foreach(path, headers: true) do |row|
      hash = row.to_hash
      book = Book.new
      book.title = hash["title"]
      book.author = hash["author"]
      book.date = hash["date"]
      book.uuid = hash["uuid"]
      book.publisher = hash["publisher"]
      list_of_books << book
    end
    self.uuid = UUID.new.generate
    self.books = list_of_books
    self
  end
end
