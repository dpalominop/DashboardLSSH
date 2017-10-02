class State < ApplicationRecord
  has_many :platforms

  validates :name,  :presence => true,  :uniqueness => {:case_sensitive => false}
end
