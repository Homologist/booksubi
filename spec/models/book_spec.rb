require 'rails_helper'

RSpec.describe Book, type: :model do
  let (:test_file) { "spec/test.csv" }
  let (:double_uuid_test_file) { "spec/double_uuid_test.csv" }
  let (:missing_uuid_test_file) { "spec/double_uuid_test.csv" }
  
  it "should create a book" do
    csv  = FactoryBot.create(:csv_book)
    book = csv.books.build
    book.uuid = "testuuid"
    expect(book.save).to eq(true)
  end

  it "should not create two books with the same uuid" do
    user = FactoryBot.create(:user)
    csv1 = user.csv_books.build
    csv1.path = double_uuid_test_file
    csv1.name = "test.csv"
    csv1.custom_build.save
    expect(CsvBook.count).to eq(0)
    expect(Book.count).to eq(0)
  end

  it "should not create two books with the same uuid" do
    user = FactoryBot.create(:user)
    csv1 = user.csv_books.build
    csv1.path = double_uuid_test_file
    csv1.name = "test.csv"
    csv1.custom_build.save
    expect(CsvBook.count).to eq(0)
    expect(Book.count).to eq(0)
  end

  it "should not create two books with the same uuid" do
    user = FactoryBot.create(:user)
    csv1 = user.csv_books.build
    csv1.path = missing_uuid_test_file
    csv1.name = "test.csv"
    csv1.custom_build.save
    expect(CsvBook.count).to eq(0)
    expect(Book.count).to eq(0)
  end
end
