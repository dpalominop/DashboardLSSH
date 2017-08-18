class Platform < ApplicationRecord
  belongs_to :state
  
  validates :name,  :presence => true,  :uniqueness => {:case_sensitive => false}
end
