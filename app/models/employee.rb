class Employee < ApplicationRecord
    belongs_to :area

    has_many :command_list_employees, :dependent => :destroy
    has_many :command_lists, through: :command_list_employees

    validates :name,    :presence => true
    validates :username,    :presence => true, :uniqueness => {:case_sensitive => false}
    validates :document,    :presence => true, :uniqueness => {:case_sensitive => false}
end
