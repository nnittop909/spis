class Position < ApplicationRecord

	has_many :terms
	has_many :members, through: :terms, source: :termable, source_type: "Member"

	enum alias_name: [:vgov, :bmd1, :bmd2, :pcl, :liga, :sk]

	def self.for_members
		all.where.not(name: "Committee")
	end

	def self.as_board_member
		bmd1 + bmd2
	end

	def to_s
		name
	end
end
