class Forum < ApplicationRecord
	has_many :forum_attendees
	has_many :forum_committees
	has_many :committees, through: :forum_committees
	has_many :considered_ordinances
	has_many :ordinances, through: :considered_ordinances
	has_many_attached :documents
	
end
