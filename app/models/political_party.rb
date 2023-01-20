class PoliticalParty < ApplicationRecord
	
	has_many :terms
	has_many :members, through: :terms, source: :termable, source_type: "Member"

	validates :name, :code, presence: true
	
	def to_s
		name
	end
end
