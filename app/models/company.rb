class Company < ApplicationRecord
  has_many :employees

  validates :name,    :presence => true, :uniqueness => {:case_sensitive => false}
  validates :ruc,    :presence => true, :uniqueness => {:case_sensitive => false}
end
