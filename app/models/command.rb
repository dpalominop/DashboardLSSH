class Command < ApplicationRecord
    has_many :command_command_lists, :dependent => :destroy
    has_many :command_lists, through: :command_command_lists

    validates :name,    :presence => true,  :uniqueness => {:case_sensitive => false}
end
