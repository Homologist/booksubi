class Book < ApplicationRecord
  belongs_to :csv_book
  validates :uuid, :uniqueness => true
end
