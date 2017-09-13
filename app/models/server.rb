class Server < ApplicationRecord
  validates :hostname,    :presence => true,  :uniqueness => {:case_sensitive => false}
  validates :ip,          :presence => true
  validates :port,        :presence => true
  validates :username,    :presence => true
  validates :password,    :presence => true

  require 'net/ssh'
  def addUser username: nil
    result = ''
    Net::SSH.start( self.ip, self.username, :password => self.password) do |ssh|
      # ssh.exec! "sudo -p 'sudo password: ' useradd #{username}"

      # Open a channel
      channel = ssh.open_channel do |channel, success|
        # Callback to receive data. It will read the
        # data and store it in result var or
        # send the password if it's required.
        channel.on_data do |channel, data|
          if data =~ /^\[sudo\] password for /
            # Send the password
            channel.send_data self.password+"\n"
          else
            # Store the data
            result += data.to_s
          end
        end
        # Request a pseudo TTY
        channel.request_pty
        # Execute the command
        channel.exec("sudo useradd #{username}")
        # Wait for response
        channel.wait
      end
      # Wait for opened channel
      channel.wait

    end
  end

  def delUser username: nil
    result = ''
    Net::SSH.start( self.ip, self.username, :password => self.password) do |ssh|
      # ssh.exec! "sudo -p 'sudo password: ' userdel -r -f #{username}"

      # Open a channel
      channel = ssh.open_channel do |channel, success|
        # Callback to receive data. It will read the
        # data and store it in result var or
        # send the password if it's required.
        channel.on_data do |channel, data|
          if data =~ /^\[sudo\] password for /
            # Send the password
            channel.send_data self.password+"\n"
          else
            # Store the data
            result += data.to_s
          end
        end
        # Request a pseudo TTY
        channel.request_pty
        # Execute the command
        channel.exec("sudo userdel -r -f #{username}")
        # Wait for response
        channel.wait
      end
      # Wait for opened channel
      channel.wait
    end
  end

  def ping hostname: nil
    Net::SSH.start( self.ip, self.username, :password => self.password) do |ssh|
      @ping = ssh.exec! "ping -w 1 #{hostname}"
    end
    @ping
  end

  def traceroute hostname: nil
    Net::SSH.start( self.ip, self.username, :password => self.password) do |ssh|
      @traceroute = ssh.exec! "traceroute #{hostname}"
    end
    @traceroute
  end
end
