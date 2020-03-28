class CreateCsvBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :csv_books do |t|
      t.string :name
      t.string :uuid
      t.string :title
      t.string :author
      t.date :date
      t.string :publisher

      t.timestamps
    end
  end
end
