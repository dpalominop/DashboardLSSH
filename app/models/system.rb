class System < ApplicationRecord
  belongs_to :platform

  validates :name,  :presence => true,  :uniqueness => {:case_sensitive => false}
end
