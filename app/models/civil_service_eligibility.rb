class CivilServiceEligibility < ApplicationRecord
	has_many :members

	def to_s
		name
	end
end
