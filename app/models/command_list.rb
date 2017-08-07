class CommandList < ApplicationRecord
    belongs_to :network_element
    belongs_to :role

    has_many :command_command_lists, :dependent => :destroy
    has_many :commands, through: :command_command_lists

    has_many :command_list_sudo_commands, :dependent => :destroy
    has_many :sudo_commands, through: :command_list_sudo_commands

    has_many :command_list_employees, :dependent => :destroy
    has_many :employees, through: :command_list_employees

    validates :name,    :presence => true,  :uniqueness => true, :case_sensitive => false

    validates :network_element_id, :presence => true
    validates :role_id, :presence => true

    validates :network_element_id, uniqueness: { :case_sensitive => false, scope: :role_id, message: "This combination with Role has been taken" }
    validates :role_id, uniqueness: { :case_sensitive => false, scope: :network_element_id, message: "This combination with Network Element has been taken" }
end
