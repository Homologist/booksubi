require 'rails_helper'

RSpec.describe Book, type: :model do
  it "should create a book" do
    csv  = FactoryBot.create(:csv_book)
    book = csv.books.build
    book.uuid = "testuuid"
    expect(book.save).to eq(true)
  end

  describe "two books with identical uuid" do
    it "should not create two books with the same uuid" do
      csv  = FactoryBot.create(:csv_book)
      book = csv.books.build
      book.uuid = "testuuid"
      book2 = csv.books.build
      book2.uuid = "testuuid"
      
      expect(book.save).to eq(true)
      expect(book2.save).to eq(false)
    end
  end

  describe "a book with a uuid missing" do
    it "should not create two books with the same uuid" do
      csv  = FactoryBot.create(:csv_book)
      book = csv.books.build
      book.uuid = nil
      expect(book.save).to eq(false)
    end
  end
end
