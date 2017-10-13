# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User Admin
User.create!(name: 'Administador', username: 'admin', email: 'admin@example.com', role: 'admin',password: 'password', password_confirmation: 'password')
# Default Settings
GlobalSetting.create!()
DefaultPermission.create!()
# Default Protocols
Protocol.create!(name: 'ssh')
Protocol.create!(name: 'telnet')
# Default Roles
Role.create!(name: 'Ingeniería')
Role.create!(name: 'Soporte')
#Default Permit Commands
Command.create!(name: 'ls')
Command.create!(name: 'cd')
#Default Exclude Commands
ExcludeCommand.create!(name: 'ls')
ExcludeCommand.create!(name: 'cd')
# Default SudoCommands
SudoCommand.create!(name: 'ls')
SudoCommand.create!(name: 'cd')
# Default States
State.create!(name: 'development')
State.create!(name: 'production')
# Default Company
Company.create!(name: 'Telefónica', ruc: "20102010201")
