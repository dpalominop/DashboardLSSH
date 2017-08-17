class Leadership < ApplicationRecord
    belongs_to :management

    validates :name,  :presence => true,  :uniqueness => {:case_sensitive => false}
end
