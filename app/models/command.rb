class Command < ApplicationRecord
    has_many :command_command_lists
    has_many :command_lists, through: :command_command_lists
end
