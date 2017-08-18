class Type < ApplicationRecord
  belongs_to :system

  validates :name,  :presence => true,  :uniqueness => {:case_sensitive => false}
end
