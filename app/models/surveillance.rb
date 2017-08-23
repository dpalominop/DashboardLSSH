class Surveillance < ApplicationRecord
  belongs_to :leadership

  has_many :platform_surveillances, :dependent => :destroy
  has_many :platforms, through: :platform_surveillances

  has_many :employees

  validates :name,  :presence => true,  :uniqueness => {:case_sensitive => false}
end
