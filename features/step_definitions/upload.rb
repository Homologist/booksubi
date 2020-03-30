When("I upload a valid csv") do
  load "#{Rails.root}/features/support/stubs.rb"
  page.attach_file('csv_book_file', 'spec/test.csv')
  click_button "Upload Book"
end

Then("I have a valid csv in my account") do
  expect(@user.csv_books.count).to eq(1)
  @uuid1 = @user.csv_books.first.uuid
  expect(Book.count).to eq(2)
end

Then("I have a csv sent to S{int}") do |int|
  expect(WebMock).to have_requested(:put, /https:\/\/books-ubi\.s3\.eu-west-2\.amazonaws.com(.*)/)
end

Then("I have a the url of the file sent to the bonnus destination") do
  expect(WebMock).to have_requested(:post, "https://requestb.in/14rl2ir1")
end

Then("I view all my csv") do
  expect(page.all("#created_book tr.table-danger th").map(&:text).count).to eq(2)
  expect(page.all("#all_books tr.table-danger th").map(&:text).count).to eq(2)
end

Then("I see the uuid for the file created") do
  expect(page.all("#created_book tr.table-danger th").map(&:text)).to_not eq([nil, nil])
  expect(page.all("#all_books tr.table-danger th").map(&:text)).to_not eq([nil, nil])
end

Given("a csv already uploaded") do
  FactoryBot.create(:csv_book, user: @user, books: [Book.new(uuid: "testuuid1", title: "test title", author: "mike", publisher: "ceo")])
end

When("I visit the index") do
  visit csv_books_path
end

Then("I have no new valid csv in my account") do
  expect(page.all("#all_books tbody tr").count).to eq(1) 
end

Given("a csv already uploaded with the fix uuid {string}") do |string|
  FactoryBot.create(:csv_book, user: @user, books: [Book.new(uuid: "testuuid1", title: "test title", author: "mike", publisher: "ceo")])
  UUID.any_instance.stub(:generate).and_return(string)
end
