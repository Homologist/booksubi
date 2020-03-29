class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :uuid
      t.string :title
      t.string :author
      t.date :date
      t.string :publisher

      t.timestamps
    end

    add_reference :books, :csv_book, foreign_key: true
  end
end
