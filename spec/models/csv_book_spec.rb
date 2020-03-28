require 'rails_helper'

RSpec.describe CsvBook, type: :model do
  let (:test_file) { "spec/test.csv" }

  it "should have all the field correctly populated" do
    csv1 = CsvBook.new
    csv1.file = test_file
    csv1.custom_save
    csv1 = CsvBook.last
    expect(csv1.title).to eq("Mike")
    expect(csv1.name).to eq("test.csv")
    expect(csv1.author).to eq("Chris")
    expect(csv1.date).to eq((Date.new(1983, 9,9)))
    expect(csv1.uuid).to_not eq(nil)
    expect(csv1.publisher).to eq("cool")
  end

  it "should not save two csv woth the same name" do
    csv1 = CsvBook.new
    csv2 = CsvBook.new
    csv1.file = test_file
    csv2.file = test_file
    csv1.custom_save
    expect(csv2.custom_save).to eq(false)
    expect(CsvBook.count).to eq(1)

  end
end
