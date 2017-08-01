class Area < ApplicationRecord
    has_many :area_network_elements, :dependent => :destroy
    has_many :network_elements, through: :area_network_elements

    has_many :employees

    validates :name,    :presence => true,  :uniqueness => true, :case_sensitive => false
end
