class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username,    :presence => true,  :uniqueness => true, :case_sensitive => false
  validates :role,        :presence => true

  ROLES = %i[admin user banned]
end
