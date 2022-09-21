class Position < ApplicationRecord

	has_many :terms
	has_many :members, through: :terms, source: :termable, source_type: "Member"

	def self.for_members
		all.where.not(name: "Committee")
	end

	def to_s
		name
	end
end
