class Book < ActiveRecord::Base
  attr_accessible :title, :author, :year, :isbn, :description
end
