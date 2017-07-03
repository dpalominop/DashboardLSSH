class Employee < ApplicationRecord
    belongs_to :area

    has_many :command_list_employees
    has_many :command_lists, through: :command_list_employees
end
