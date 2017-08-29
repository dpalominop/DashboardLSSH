class CommandListExcludeCommand < ApplicationRecord
  belongs_to :command_list
  belongs_to :exclude_command
end
