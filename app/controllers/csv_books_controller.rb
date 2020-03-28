class CsvBooksController < InheritedResources::Base

  def create
    filename =  csv_book_params[:file].original_filename
    @csv_book = CsvBook.new(name: filename)

    respond_to do |format|
       if @csv_book.save
          format.html { redirect_to @csv_book, notice: 'CSV was successfully created.' }
          format.json { render :show, status: :created, location: @csv_book }
       else
          format.html { render :new }
          format.json { render json: @csv_book.errors, status: :unprocessable_entity }
       end
    end
  end

  private

    def csv_book_params
      params.require(:csv_book).permit(:file)
    end

end
