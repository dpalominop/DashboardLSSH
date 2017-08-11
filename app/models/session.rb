class Session < ApplicationRecord
  # belongs_to :employee
  # belongs_to :network_element
  # belongs_to :server

  has_attached_file :document #, styles: {thumbnail: "60x60#"}
  validates_attachment :document, content_type: { content_type: "text/plain" }
end
