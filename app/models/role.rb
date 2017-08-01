class Role < ApplicationRecord
  validates :name,    :presence => true,  :uniqueness => true, :case_sensitive => false
end
