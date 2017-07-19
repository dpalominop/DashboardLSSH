class CommandListSudoCommand < ApplicationRecord
  belongs_to :command_list
  belongs_to :sudo_command
end
