class Category < ApplicationRecord
	has_many :ordinances, dependent: :destroy
	has_many :resolutions, dependent: :destroy

	def to_s
		name
	end
end
