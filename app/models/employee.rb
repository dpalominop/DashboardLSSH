class Employee < ApplicationRecord
    #belongs_to :area

    has_many :command_list_employees, :dependent => :destroy
    has_many :command_lists, through: :command_list_employees

    validates :username,    :presence => true
    validates :document,    :presence => true
end
