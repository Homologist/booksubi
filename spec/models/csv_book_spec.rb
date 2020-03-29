require 'rails_helper'

RSpec.describe CsvBook, type: :model do
  let (:test_file) { "spec/test.csv" }
  let (:double_uuid_test_file) { "spec/double_uuid_test.csv" }
  let (:missing_uuid_test_file) { "spec/double_uuid_test.csv" }

  it "should have all the field correctly populated" do
    user = FactoryBot.create(:user)
    csv1 = user.csv_books.build
    csv1.path = test_file
    csv1.name = "test.csv"
    expect(Book.count).to eq(0)
    csv1.custom_build.save
    books = csv1.books
    expect(books.map(&:title)).to eq(["Ce0", "Ce1"])
    expect(books.map(&:author)).to eq(["Chsris0", "Chsris1"])
    expect(books.map(&:date)).to eq([Date.new(1983, 9,9), Date.new(1983, 9, 10)])
    expect(books.map(&:uuid)).to_not eq([nil, nil])
    expect(books.map(&:publisher)).to eq(["cool1", "cool2"])
    expect(csv1.name).to eq("test.csv")
    expect(csv1.uuid).to_not eq(nil)
  end

  it "should not save two csv with the same uuid" do
    user = FactoryBot.create(:user)
    csv1 = user.csv_books.build
    csv2 = user.csv_books.build
    csv1.path = test_file
    csv2.path = test_file
    csv1.name = "test.csv"
    csv2.name = "test.csv"
    csv1.custom_build.save
    csv2.custom_build
    csv2.uuid = csv1.uuid
    expect(csv2.save).to eq(false)
    expect(CsvBook.count).to eq(1)
  end
end
