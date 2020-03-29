require 'rails_helper'

RSpec.describe CsvBooksController, type: :controller do
  before(:each) do
      @user = FactoryBot.create(:user)
      sign_in @user
  end

  describe "GET index" do
    it "works" do
      FactoryBot.create(:csv_book, user: @user)
      @user = User.first
      @csv_book = CsvBook.first
      
      visit "csv_books"
      
      expect(page).to have_content("All Books")
    end

  end

  describe "POST create" do
    it "send all the information to aws" do
      fix_uuid = "testuuidbis"
      UUID.any_instance.stub(:generate).and_return(fix_uuid)
      WebMock.stub_request(:put, "https://books-ubi.s3.eu-west-2.amazonaws.com/#{fix_uuid}").to_return(status: 200, body: "", headers: {})
      file = Rack::Test::UploadedFile.new 'spec/test.csv', 'text/csv'
      post :create, :params => { :csv_book => {:file => file} }
      
      expect(WebMock).to have_requested(:put, "https://books-ubi.s3.eu-west-2.amazonaws.com/#{fix_uuid}")
    end

    it "save the file uploaded" do
      fix_uuid = "testuuidbis"
      UUID.any_instance.stub(:generate).and_return(fix_uuid)
      WebMock.stub_request(:put, "https://books-ubi.s3.eu-west-2.amazonaws.com/#{fix_uuid}").to_return(status: 200, body: "", headers: {})
      file = Rack::Test::UploadedFile.new 'spec/test.csv', 'text/csv'

      expect{
        post(:create, :params => { :csv_book => {:file => file} })
      }.to change{CsvBook.all.count}.from(0).to(1)
    end
  end
end
