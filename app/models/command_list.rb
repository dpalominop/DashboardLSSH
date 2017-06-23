class CommandList < ApplicationRecord
  belongs_to :network_element
  belongs_to :role
end
