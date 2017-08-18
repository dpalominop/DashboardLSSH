class NetworkElement < ApplicationRecord
    has_many :surveillance_network_elements, :dependent => :destroy
    has_many :surveillances, through: :surveillance_network_elements

    has_many :command_lists

    belongs_to :type

    validates :name,    :presence => true,  :uniqueness => {:case_sensitive => false}
    validates :ip,    :presence => true,  :uniqueness => {:case_sensitive => false}
    validates :port, :presence => true
    validates :protocol_id, :presence => true

    # def clone!
    #   ne = self.dup
    #   ne.name = "#{self.name} #{DateTime.now}"
    #   ne.ip = "#{self.ip} #{DateTime.now}"
    #   ne.save!
    #
    #   self.send( :areas ).each do |area|
    #     print area.id
    #     ne.area_network_elements.create!(area_id: area.id)
    #   end
    #
    #   return ne
    # end
end
