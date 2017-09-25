class Platform < ApplicationRecord
  has_many :platform_surveillances, :dependent => :destroy
  has_many :surveillances, through: :platform_surveillances
  has_many :network_elements

  belongs_to :state

  validates :name,  :presence => true,  :uniqueness => {:case_sensitive => false}
end
