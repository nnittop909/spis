class Attandee < ApplicationRecord
  has_many :attendances
  has_many :attended_sessions, through: :attendances, source: :eventable, source_type: "SpSession"
  has_many :attended_hearings, through: :attendances, source: :eventable, source_type: "Hearing"
  has_many :attended_meetings, through: :attendances, source: :eventable, source_type: "Meeting"
end
