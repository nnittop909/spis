class Position < ApplicationRecord

	has_many :terms
	has_many :members, through: :terms, source: :termable, source_type: "Member"

	enum alias_name: [:vgov, :bmd1, :bmd2, :pcl, :liga, :sk]

	validates :name, presence: true

	def to_s
		name
	end

	def self.for_members
		all.where.not(name: "Committee")
	end

	def self.as_board_member
		bmd1 + bmd2
	end
end
