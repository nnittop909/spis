class Attendance < ApplicationRecord
  belongs_to :attendee
  belongs_to :eventable, polymorphic: true

  enum attendee_role: [:presiding_officer, :plain_attendee]
end
