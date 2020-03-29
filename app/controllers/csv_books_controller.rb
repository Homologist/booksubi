class CsvBooksController < InheritedResources::Base
  def index
    @all_my_books = Book.joins(:csv_book).where(csv_books: {user_id: current_user.id})
  end

  def show
    @all_my_books = Book.joins(:csv_book).where(csv_books: {user_id: current_user.id})
    @new_books = CsvBook.find(csv_book_id).books
  end

  def create
    @csv_book      = current_user.csv_books.build
    @csv_book.path = csv_book_params[:file].path
    @csv_book.name = csv_book_params[:file].original_filename
    respond_to do |format|
      if @csv_book.custom_build.save
         s3 = Aws::S3::Resource.new(region: 'eu-west-2')
         obj = s3.bucket('books-ubi').object(@csv_book.uuid)
         obj.upload_file(@csv_book.path)
         format.html { redirect_to @csv_book, notice: 'CSV was successfully created.' }
         format.json { render :show, status: :created, location: @csv_book }
      else
         format.html { render :new }
         format.json { render json: @csv_book.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def csv_book_id
      params.permit(:id)[:id]
    end

    def csv_book_params
      params.require(:csv_book).permit(:file)
    end

end
