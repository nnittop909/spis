class Municipality < ApplicationRecord
	has_many :municipal_ordinances

	def to_s
		name
	end
end
