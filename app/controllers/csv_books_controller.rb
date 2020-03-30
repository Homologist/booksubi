class CsvBooksController < ApplicationController
  def show
    @all_my_csv = current_user.csv_books
    @new_books = CsvBook.find(csv_book_id).books
  end

  def create
    @csv_book      = current_user.csv_books.build
    @csv_book.name = csv_book_params[:file].original_filename
    respond_to do |format|
      if @csv_book.custom_build(csv_book_params[:file]).save
        send_url_to_service
        format.html { redirect_to @csv_book, notice: 'CSV was successfully created.' }
        format.json { render :show, status: :created, location: @csv_book }
      else
        format.html { render :new }
        format.json { render json: @csv_book.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @csv_book = CsvBook.new
  end

  private

  def send_url_to_service
    Net::HTTP.post_form(URI.parse('https://requestb.in/14rl2ir1'),
                        { 's3_url' => @csv_book.file.url })
  rescue SocketError => e
    Rails.logger.error(e)
  end

  def csv_book_id
    params.permit(:id)[:id]
  end

  def csv_book_params
    params.require(:csv_book).permit(:file)
  end
end
