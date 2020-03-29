When("I go the home page") do
  visit root_path
end

Then("I should see the login page") do
  expect(page).to have_content("Log in")
end

Given("a valid user") do
  @user = User.create!({
             :email => "cedric@gmail.com",
             :password => "12345678",
             :password_confirmation => "12345678"
           })
end

When("I log in") do
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password

  click_button "Log in"
end

Then("I should see the upload page") do
  expect(page.body).to self.include("Upload")
end
