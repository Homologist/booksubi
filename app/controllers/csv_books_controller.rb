class CsvBooksController < ApplicationController
  def show
    @all_my_csv = current_user.csv_books
    @new_books = CsvBook.find(csv_book_id).books
  end

  def create
    set_csv_book

    respond_to do |format|
      if @csv_book.custom_build.save
        send_file_to_aws
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
                        { 's3_url' => @obj.public_url })
  rescue SocketError => e
    Rails.logger.error(e)
  end

  def send_file_to_aws
    s3 = Aws::S3::Resource.new(region: 'eu-west-2')
    @obj = s3.bucket('books-ubi').object(@csv_book.uuid)
    @obj.upload_file(@csv_book.path)
  end

  def set_csv_book
    @csv_book      = current_user.csv_books.build
    @csv_book.path = csv_book_params[:file].path
    @csv_book.name = csv_book_params[:file].original_filename
  end

  def csv_book_id
    params.permit(:id)[:id]
  end

  def csv_book_params
    params.require(:csv_book).permit(:file)
  end
end
