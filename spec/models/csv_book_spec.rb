require 'rails_helper'

RSpec.describe CsvBook, type: :model do
  let (:test_file) { "spec/test.csv" }
  let (:double_uuid_test_file) { "spec/double_uuid_test.csv" }
  let (:missing_uuid_test_file) { "spec/double_uuid_test.csv" }

  it "should have all the field correctly populated" do
    user = FactoryBot.create(:user)
    csv1 = user.csv_books.build
    csv1.name = "test.csv"
    fix_uuid = "testuuidbis"
    
    file = Rack::Test::UploadedFile.new 'spec/test.csv', 'text/csv'
    allow_any_instance_of(UUID).to receive(:generate).and_return(fix_uuid) 
    
    expect{
      csv1.custom_build(file).save
    }.to change{Book.count}.from(0).to(2)

    books = csv1.books
    expect(books.map(&:title)).to eq(["Ce0", "Ce1"])
    expect(books.map(&:author)).to eq(["Chsris0", "Chsris1"])
    expect(books.map(&:date)).to eq([Date.new(1983, 9,9), Date.new(1983, 9, 10)])
    expect(books.map(&:uuid)).to_not eq([nil, nil])
    expect(books.map(&:publisher)).to eq(["cool1", "cool2"])
    expect(csv1.name).to eq("test.csv")
    expect(csv1.file.identifier).to eq("testtestuuidbis.csv")
    expect(csv1.uuid).to eq("testuuidbis")
  end

  it "should not save a new csv if a book violate a business rule" do
    user = FactoryBot.create(:user)
    csv1 = user.csv_books.build
    csv2 = user.csv_books.build
    csv1.name = "test.csv"
    csv2.name = "test2.csv"
    
    file = Rack::Test::UploadedFile.new 'spec/test.csv', 'text/csv'
    file2 = Rack::Test::UploadedFile.new 'spec/test_bis.csv', 'text/csv'
    
    csv1.custom_build(file).save
    csv2.custom_build(file2)
    csv2.uuid = csv1.uuid
    
    expect(csv2.save).to eq(false)
    expect(CsvBook.count).to eq(1)
  end
  
  describe "a csv with a uuid already recorded" do
    it "should not create a new entry" do
      user = FactoryBot.create(:user)
      csv1 = user.csv_books.build
      csv2 = user.csv_books.build
      csv1.name = "test.csv"
      csv2.name = "test_bis.csv"
      fix_uuid = "testuuidbis"
      
      file = Rack::Test::UploadedFile.new 'spec/test.csv', 'text/csv'
      file2 = Rack::Test::UploadedFile.new 'spec/test_bis.csv', 'text/csv'
      allow_any_instance_of(UUID).to receive(:generate).and_return(fix_uuid) 
      
      
      csv1.custom_build(file).save
      expect{
        csv2.custom_build(file2).save
      }.to_not change(CsvBook,:count)
    end
  end

  describe "a csv with a uuid missing" do
    it "should not create a new entry" do
      user = FactoryBot.create(:user)
      csv1 = user.csv_books.build
      csv1.name = "test.csv"
      
      file = Rack::Test::UploadedFile.new missing_uuid_test_file, 'text/csv'
      
      expect{
      }.to_not change(CsvBook, :count)
        
    end
  end

  describe "two books with identical uuid" do
    it "should not create two books with the same uuid" do
      user = FactoryBot.create(:user)
      csv1 = user.csv_books.build
      csv1.name = "double_uuid_test.csv"

      file = Rack::Test::UploadedFile.new double_uuid_test_file, 'text/csv'
      
      csv1.custom_build(file).save
      expect(CsvBook.count).to eq(0)
      expect(Book.count).to eq(0)
    end
  end

  describe "a book with a uuid missing" do
    it "should not create two books with the same uuid" do
      user = FactoryBot.create(:user)
      csv1 = user.csv_books.build
      csv1.name = "missing_uuid_test.csv"

      file = Rack::Test::UploadedFile.new missing_uuid_test_file, 'text/csv'
      
      csv1.custom_build(file).save
      expect(CsvBook.count).to eq(0)
      expect(Book.count).to eq(0)
    end
  end
end
