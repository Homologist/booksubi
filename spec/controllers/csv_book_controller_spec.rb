require 'rails_helper'

RSpec.describe CsvBooksController, type: :controller do
  before(:each) do
      @user = FactoryBot.create(:user)
      sign_in @user
  end

  after(:each) do
      sign_out @user
  end

  describe "GET new" do
    it "successfully render new" do
      FactoryBot.create(:csv_book, user: @user)
      
      get :new 
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET index" do
    it "successfully render index" do
      FactoryBot.create(:csv_book, user: @user)
      
      get :index 
      
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    it "send all the information to aws" do
      fix_uuid = "testuuidbis"
      allow_any_instance_of(UUID).to receive(:generate).and_return(fix_uuid) 
      WebMock.stub_request(:put, "https://books-ubi.s3.eu-west-2.amazonaws.com/#{fix_uuid}").to_return(status: 200, body: "", headers: {})
      WebMock.stub_request(:post, "https://requestb.in/14rl2ir1").to_return(status: 200, body: "", headers: {})      
      
      file = Rack::Test::UploadedFile.new 'spec/test.csv', 'text/csv'
      post :create, :params => { :csv_book => {:file => file} }
      
      expect(WebMock).to have_requested(:put, "https://books-ubi.s3.eu-west-2.amazonaws.com/#{fix_uuid}")
      expect(WebMock).to have_requested(:post, "https://requestb.in/14rl2ir1")
    end

    it "save the file uploaded" do
      fix_uuid = "testuuidbis"
      allow_any_instance_of(UUID).to receive(:generate).and_return(fix_uuid) 
      
      WebMock.stub_request(:put, "https://books-ubi.s3.eu-west-2.amazonaws.com/#{fix_uuid}").to_return(status: 200, body: "", headers: {})
      WebMock.stub_request(:post, "https://requestb.in/14rl2ir1").to_return(status: 200, body: "", headers: {})      
      
      file = Rack::Test::UploadedFile.new 'spec/test.csv', 'text/csv'

      expect{
        post(:create, :params => { :csv_book => {:file => file} })
      }.to change{CsvBook.all.count}.from(0).to(1)
    end
  end
end
