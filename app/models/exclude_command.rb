class ExcludeCommand < ApplicationRecord
  has_many :command_list_exclude_commands, :dependent => :destroy
  has_many :command_lists, through: :command_list_exclude_commands

  validates :name,    :presence => true,  :uniqueness => {:case_sensitive => false}
end
