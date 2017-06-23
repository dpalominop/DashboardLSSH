class CommandCommandList < ApplicationRecord
  belongs_to :command
  belongs_to :command_list
end
