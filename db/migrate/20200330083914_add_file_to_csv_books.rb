class AddFileToCsvBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :csv_books, :file, :string
  end
end
