# This class representing the book data objects

class Book < ApplicationRecord
  belongs_to :csv_book
  validates :uuid, uniqueness: true, presence: true
end
