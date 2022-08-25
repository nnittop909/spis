class Stage < ApplicationRecord

	has_many :stagings

	enum phase: [:first_reading, :second_reading, :third_reading, :lce_approval, :amended]

	def to_s
		name
	end

end
