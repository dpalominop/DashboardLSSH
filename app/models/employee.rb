class Employee < ApplicationRecord
    belongs_to :surveillance
    has_many :sessions

    has_many :command_list_employees, :dependent => :destroy
    has_many :command_lists, through: :command_list_employees

    validates :name,    :presence => true
    validates :username,    :presence => true, :uniqueness => {:case_sensitive => false}
    validates :document,    :presence => true, :uniqueness => {:case_sensitive => false}

    ACTIVED = 'active'
    BLOCKED = 'blocked'
    DELETED = 'delete'

    state_machine :status, initial: ACTIVED do
      event :bloquear do
        transition ACTIVED => BLOCKED
      end

      event :eliminar do
        transition BLOCKED => DELETED
      end
    end
end
