class CommandList < ApplicationRecord
    belongs_to :network_element
    belongs_to :role

    has_many :command_command_lists
    has_many :commands, through: :command_command_lists
end
