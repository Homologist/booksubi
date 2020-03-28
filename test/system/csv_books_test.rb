require "application_system_test_case"

class CsvBooksTest < ApplicationSystemTestCase
  setup do
    @csv_book = csv_books(:one)
  end

  test "visiting the index" do
    visit csv_books_url
    assert_selector "h1", text: "Csv Books"
  end

  test "creating a Csv book" do
    visit csv_books_url
    click_on "New Csv Book"

    fill_in "Author", with: @csv_book.author
    fill_in "Date", with: @csv_book.date
    fill_in "Id", with: @csv_book.id
    fill_in "Name", with: @csv_book.name
    fill_in "Publisher", with: @csv_book.publisher
    fill_in "Title", with: @csv_book.title
    click_on "Create Csv book"

    assert_text "Csv book was successfully created"
    click_on "Back"
  end

  test "updating a Csv book" do
    visit csv_books_url
    click_on "Edit", match: :first

    fill_in "Author", with: @csv_book.author
    fill_in "Date", with: @csv_book.date
    fill_in "Id", with: @csv_book.id
    fill_in "Name", with: @csv_book.name
    fill_in "Publisher", with: @csv_book.publisher
    fill_in "Title", with: @csv_book.title
    click_on "Update Csv book"

    assert_text "Csv book was successfully updated"
    click_on "Back"
  end

  test "destroying a Csv book" do
    visit csv_books_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Csv book was successfully destroyed"
  end
end
