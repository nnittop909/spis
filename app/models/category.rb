class Category < ApplicationRecord
	has_many :ordinances, dependent: :destroy
	has_many :resolutions, dependent: :destroy

	validates :name, presence: true

	def to_s
		name
	end
end
