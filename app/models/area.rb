class Area < ApplicationRecord
    belongs_to :management

    has_many :area_network_elements, :dependent => :destroy
    has_many :network_elements, through: :area_network_elements

    has_many :employees

    validates :name,  :presence => true,  :uniqueness => {:case_sensitive => false}
end
