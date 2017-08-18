class Management < ApplicationRecord
  belongs_to :direction

  validates :name,  :presence => true,  :uniqueness => {:case_sensitive => false}
end
