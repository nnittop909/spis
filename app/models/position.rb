class Position < ApplicationRecord

	has_many :terms
	has_many :members, through: :terms, source: :termable, source_type: "Member"

	def to_s
		name
	end
end
