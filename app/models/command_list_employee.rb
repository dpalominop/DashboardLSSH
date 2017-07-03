class CommandListEmployee < ApplicationRecord
  belongs_to :command_list
  belongs_to :employee
end