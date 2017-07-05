class CommandList < ApplicationRecord
    belongs_to :network_element
    belongs_to :role

    has_many :command_command_lists, :dependent => :destroy
    has_many :commands, through: :command_command_lists

    has_many :command_list_employees, :dependent => :destroy
    has_many :employees, through: :command_list_employees

    validates :network_element_id, :presence => true
    validates :role_id, :presence => true
end
