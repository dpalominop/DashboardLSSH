class Session < ApplicationRecord
  # require "paperclip/storage/sftp"
  # belongs_to :employee
  # belongs_to :network_element
  # belongs_to :server
  config = YAML.load_file('config/fileserver.yml')
  has_attached_file :document, #, styles: {thumbnail: "60x60#"}
                    :path => "/var/log/sa/:filename",
                    :url => "http://"+config['hostname']+"/sa/:filename",
                    storage: :sftp,
                    sftp_options: {
                      host: config['hostname'],
                      user: config['username'],
                      password: config['password'],
                      port: 22
                    }
  validates_attachment :document,
                        content_type: { content_type: "text/plain" }
end
