class Employee < ApplicationRecord
    belongs_to :area

    has_many :command_list_employees, :dependent => :destroy
    has_many :command_lists, through: :command_list_employees

    validates :username,    :presence => true
    validates :document,    :presence => true
    validates :area_id,     :presence => false
    validates :name,        :presence => false
    validates :lastname,    :presence => false
    validates :command_list_ids, :presence => false
end
