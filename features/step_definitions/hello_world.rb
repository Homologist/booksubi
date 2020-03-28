Given("an non connected user") do
end

When("I go the home page") do
  visit root_path
end

Then("I should see the login page") do
  expect(page).to have_content("login")
end
