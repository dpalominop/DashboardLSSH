class Direction < ApplicationRecord
  belongs_to :vice_presidency

  validates :name,  :presence => true,  :uniqueness => {:case_sensitive => false}
end
