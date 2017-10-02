class Protocol < ApplicationRecord
  has_many :network_elements
  
  validates :name,    :presence => true,  :uniqueness => {:case_sensitive => false}
end
