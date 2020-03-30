require 'csv'

class CsvUploader < CarrierWave::Uploader::Base
  storage :aws
end

# This class represent the main business object the csv file containing books

class CsvBook < ApplicationRecord
  validates :uuid, uniqueness: true, presence: true
  has_many :books
  belongs_to :user
  mount_uploader :file, CsvUploader

  def custom_build(file)
    list_of_books = []
    CSV.foreach(file.path, headers: true) do |row|
      hash = row.to_hash
      book = Book.new
      book.title = hash["title"]
      book.author = hash["author"]
      book.date = hash["date"]
      book.uuid = hash["uuid"]
      book.publisher = hash["publisher"]
      list_of_books << book
    end
    append_uuid(file)
    self.books = list_of_books
    self
  end

  def append_uuid(old_file)
    self.uuid = UUID.new.generate
    new_path  = File.dirname(old_file.path) + "/" + File.basename(old_file.original_filename, ".csv") + uuid + File.extname(old_file)
    File.rename(old_file, new_path)
    self.file = File.open(new_path)
  end
end
