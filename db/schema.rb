# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170906211819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "command_command_lists", force: :cascade do |t|
    t.bigint "command_id"
    t.bigint "command_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["command_id"], name: "index_command_command_lists_on_command_id"
    t.index ["command_list_id"], name: "index_command_command_lists_on_command_list_id"
  end

  create_table "command_list_employees", force: :cascade do |t|
    t.bigint "command_list_id"
    t.bigint "employee_id"
    t.index ["command_list_id"], name: "index_command_list_employees_on_command_list_id"
    t.index ["employee_id"], name: "index_command_list_employees_on_employee_id"
  end

  create_table "command_list_exclude_commands", force: :cascade do |t|
    t.bigint "command_list_id"
    t.bigint "exclude_command_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["command_list_id"], name: "index_command_list_exclude_commands_on_command_list_id"
    t.index ["exclude_command_id"], name: "index_command_list_exclude_commands_on_exclude_command_id"
  end

  create_table "command_list_sudo_commands", force: :cascade do |t|
    t.bigint "command_list_id"
    t.bigint "sudo_command_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["command_list_id"], name: "index_command_list_sudo_commands_on_command_list_id"
    t.index ["sudo_command_id"], name: "index_command_list_sudo_commands_on_sudo_command_id"
  end

  create_table "command_lists", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "platform_id"
    t.bigint "system_id"
    t.bigint "type_id"
    t.boolean "all_commands", default: true
    t.index ["platform_id"], name: "index_command_lists_on_platform_id"
    t.index ["role_id"], name: "index_command_lists_on_role_id"
    t.index ["system_id"], name: "index_command_lists_on_system_id"
    t.index ["type_id"], name: "index_command_lists_on_type_id"
  end

  create_table "commands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_commands_on_name", unique: true
  end

  create_table "default_permissions", force: :cascade do |t|
    t.string "forbidden", default: "[';', '&', '|','`','>','<', '$(', '${']"
    t.integer "warning_counter", default: 2
    t.text "intro", default: "== My personal intro ==\nWelcome to lssh\nType '?' or 'help' to get the list of allowed commands"
    t.string "prompt", default: "%u@%h"
    t.integer "timer", default: 5
    t.integer "strict", default: 0
    t.string "history_file", default: "/var/log/sa/"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "directions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "vice_presidency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vice_presidency_id"], name: "index_directions_on_vice_presidency_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "document"
    t.bigint "surveillance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document"], name: "index_employees_on_document", unique: true
    t.index ["surveillance_id"], name: "index_employees_on_surveillance_id"
    t.index ["username"], name: "index_employees_on_username", unique: true
  end

  create_table "exclude_commands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "global_settings", force: :cascade do |t|
    t.string "logpath", default: "/var/log/lssh/"
    t.string "loglevel", default: "4"
    t.string "logfilename", default: "%y%m%d-%u"
    t.string "syslogname", default: "syslog"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leaderships", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "management_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["management_id"], name: "index_leaderships_on_management_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managements", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "direction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["direction_id"], name: "index_managements_on_direction_id"
  end

  create_table "network_elements", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "ip"
    t.integer "port"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "protocol_id"
    t.bigint "type_id"
    t.bigint "platform_id"
    t.bigint "system_id"
    t.bigint "location_id"
    t.bigint "vendor_id"
    t.index ["ip"], name: "index_network_elements_on_ip", unique: true
    t.index ["location_id"], name: "index_network_elements_on_location_id"
    t.index ["platform_id"], name: "index_network_elements_on_platform_id"
    t.index ["protocol_id"], name: "index_network_elements_on_protocol_id"
    t.index ["system_id"], name: "index_network_elements_on_system_id"
    t.index ["type_id"], name: "index_network_elements_on_type_id"
    t.index ["vendor_id"], name: "index_network_elements_on_vendor_id"
  end

  create_table "platform_surveillances", force: :cascade do |t|
    t.bigint "platform_id"
    t.bigint "surveillance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["platform_id"], name: "index_platform_surveillances_on_platform_id"
    t.index ["surveillance_id"], name: "index_platform_surveillances_on_surveillance_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vendor_id"
    t.bigint "location_id"
    t.index ["location_id"], name: "index_platforms_on_location_id"
    t.index ["state_id"], name: "index_platforms_on_state_id"
    t.index ["vendor_id"], name: "index_platforms_on_vendor_id"
  end

  create_table "protocols", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_protocols_on_name", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servers", force: :cascade do |t|
    t.string "hostname"
    t.string "ip"
    t.integer "port"
    t.string "username"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "network_element_id"
    t.bigint "server_id"
    t.datetime "initiation"
    t.string "document_file_name"
    t.string "document_content_type"
    t.integer "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_sessions_on_employee_id"
    t.index ["network_element_id"], name: "index_sessions_on_network_element_id"
    t.index ["server_id"], name: "index_sessions_on_server_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sudo_commands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_sudo_commands_on_name", unique: true
  end

  create_table "surveillances", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "leadership_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leadership_id"], name: "index_surveillances_on_leadership_id"
  end

  create_table "systems", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vice_presidencies", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "command_command_lists", "command_lists"
  add_foreign_key "command_command_lists", "commands"
  add_foreign_key "command_list_employees", "command_lists"
  add_foreign_key "command_list_employees", "employees"
  add_foreign_key "command_list_exclude_commands", "command_lists"
  add_foreign_key "command_list_exclude_commands", "exclude_commands"
  add_foreign_key "command_list_sudo_commands", "command_lists"
  add_foreign_key "command_list_sudo_commands", "sudo_commands"
  add_foreign_key "command_lists", "platforms"
  add_foreign_key "command_lists", "roles"
  add_foreign_key "command_lists", "systems"
  add_foreign_key "command_lists", "types"
  add_foreign_key "employees", "surveillances"
  add_foreign_key "network_elements", "locations"
  add_foreign_key "network_elements", "platforms"
  add_foreign_key "network_elements", "protocols"
  add_foreign_key "network_elements", "systems"
  add_foreign_key "network_elements", "types"
  add_foreign_key "network_elements", "vendors"
  add_foreign_key "platform_surveillances", "platforms"
  add_foreign_key "platform_surveillances", "surveillances"
  add_foreign_key "platforms", "locations"
  add_foreign_key "platforms", "states"
  add_foreign_key "platforms", "vendors"
  add_foreign_key "sessions", "employees"
  add_foreign_key "sessions", "network_elements"
  add_foreign_key "sessions", "servers"
end
