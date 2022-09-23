class Stage < ApplicationRecord

	has_many :stagings

	enum phase: [:first_reading, :second_reading, :third_reading, :lce_approval, :amended]

	def to_s
		name
	end

	def approved?
		alias_name == "approved_on_second_reading" || alias_name == "approved_on_third_reading" || alias_name == "vetoed" || alias_name == "approved"
	end

	def self.for_resolutions
		all.where(alias_name: ["first_reading", "approved_on_second_reading", "active_file"])
	end

	def self.for_ordinances
		all.where.not(alias_name: ["approved_on_second_reading", "active_file"])
	end

end
