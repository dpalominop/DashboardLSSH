class CommandList < ApplicationRecord
    belongs_to :platform
    belongs_to :system
    belongs_to :type
    belongs_to :role

    has_many :command_command_lists, :dependent => :destroy
    has_many :commands, through: :command_command_lists

    has_many :command_list_sudo_commands, :dependent => :destroy
    has_many :sudo_commands, through: :command_list_sudo_commands

    has_many :command_list_exclude_commands, :dependent => :destroy
    has_many :exclude_commands, through: :command_list_exclude_commands

    has_many :command_list_employees, :dependent => :destroy
    has_many :employees, through: :command_list_employees

    validates :name,    :presence => true,  :uniqueness => true, :case_sensitive => false

    validates :platform_id, :presence => true
    validates :system_id, :presence => true
    validates :type_id, :presence => true
    validates :role_id, :presence => true

    validates :platform_id, uniqueness: { :case_sensitive => false, scope: [:system, :type, :role], message: I18n.t("active_admin.combination_taken") }
    validates :system_id, uniqueness: { :case_sensitive => false, scope: [:platform, :type, :role], message: I18n.t("active_admin.combination_taken") }
    validates :type_id, uniqueness: { :case_sensitive => false, scope: [:platform, :system, :role], message: I18n.t("active_admin.combination_taken") }
    validates :role_id, uniqueness: { :case_sensitive => false, scope: [:platform, :system, :type], message: I18n.t("active_admin.combination_taken") }
end
