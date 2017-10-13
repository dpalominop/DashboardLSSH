class Employee < ApplicationRecord
    # belongs_to :surveillance
    belongs_to :company
    has_many :sessions

    has_many :command_list_employees, :dependent => :destroy
    has_many :command_lists, through: :command_list_employees

    has_many :employee_surveillances, :dependent => :destroy
    has_many :surveillances, through: :employee_surveillances

    validates :name,    :presence => true
    validates :username,    :presence => true, :uniqueness => {:case_sensitive => false}
    validates :document,    :presence => true, :uniqueness => {:case_sensitive => false}
    validates :company_id,    :presence => true

    ACTIVED = 'active'
    BLOCKED = 'blocked'
    DELETED = 'delete'

    state_machine :status, initial: ACTIVED do
      event :bloquear do
        transition ACTIVED => BLOCKED
      end

      event :desbloquear do
        transition BLOCKED => ACTIVED
      end

      event :eliminar do
        transition BLOCKED => DELETED
      end
    end
end
