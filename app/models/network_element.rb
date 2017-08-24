class NetworkElement < ApplicationRecord
    belongs_to :type
    belongs_to :system
    belongs_to :platform

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
