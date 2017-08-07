class Server < ApplicationRecord
  validates :hostname,    :presence => true,  :uniqueness => {:case_sensitive => false}
  validates :ip,          :presence => true
  validates :port,        :presence => true
  validates :username,    :presence => true
  validates :password,    :presence => true

  require 'net/ssh'
  def addUser username: nil
    Net::SSH.start( self.ip, self.username, :password => self.password) do |ssh|
      ssh.exec! "useradd #{username}"
    end
  end

  def delUser username: nil
    Net::SSH.start( self.ip, self.username, :password => self.password) do |ssh|
      ssh.exec! "userdel -r -f #{username}"
    end
  end
end
