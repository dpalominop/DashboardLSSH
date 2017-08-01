class SudoCommand < ApplicationRecord
  has_many :command_list_sudo_commands, :dependent => :destroy
  has_many :command_lists, through: :command_list_sudo_commands

  validates :name,    :presence => true,  :uniqueness => true, :case_sensitive => false
end
