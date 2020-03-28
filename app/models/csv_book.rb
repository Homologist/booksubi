require 'csv'
class CsvBook < ApplicationRecord
  validates :name, :uniqueness => true
  attr_accessor :file

  def custom_save
    CSV.foreach(file, headers: true) do |row|
      hash = row.to_hash
      self.title = hash["title"]
      self.author = hash["author"]
      self.date = hash["date"]
      self.uuid =  hash["uuid"]
      self.publisher = hash["publisher"]
    end
    self.name = File.basename(file) 
    self.uuid = self.uuid + UUID.new.generate
    save
  end
end
