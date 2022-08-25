class SpSession < ApplicationRecord
	has_many :session_attendees
	has_many :session_committees
	has_many :committees, through: :session_committees
	has_many_attached :documents
end
