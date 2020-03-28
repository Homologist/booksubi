require 'test_helper'

class CsvBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @csv_book = csv_books(:one)
  end

  test "should get index" do
    get csv_books_url
    assert_response :success
  end

  test "should get new" do
    get new_csv_book_url
    assert_response :success
  end

  test "should create csv_book" do
    assert_difference('CsvBook.count') do
      post csv_books_url, params: { csv_book: { author: @csv_book.author, date: @csv_book.date, id: @csv_book.id, name: @csv_book.name, publisher: @csv_book.publisher, title: @csv_book.title } }
    end

    assert_redirected_to csv_book_url(CsvBook.last)
  end

  test "should show csv_book" do
    get csv_book_url(@csv_book)
    assert_response :success
  end

  test "should get edit" do
    get edit_csv_book_url(@csv_book)
    assert_response :success
  end

  test "should update csv_book" do
    patch csv_book_url(@csv_book), params: { csv_book: { author: @csv_book.author, date: @csv_book.date, id: @csv_book.id, name: @csv_book.name, publisher: @csv_book.publisher, title: @csv_book.title } }
    assert_redirected_to csv_book_url(@csv_book)
  end

  test "should destroy csv_book" do
    assert_difference('CsvBook.count', -1) do
      delete csv_book_url(@csv_book)
    end

    assert_redirected_to csv_books_url
  end
end
