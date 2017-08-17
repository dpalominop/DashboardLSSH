class Surveillance < ApplicationRecord
  belongs_to :leadership

  has_many :surveillance_network_elements, :dependent => :destroy
  has_many :network_elements, through: :surveillance_network_elements

  has_many :employees
end
