class Meeting < ApplicationRecord
	include PgSearch::Model
  multisearchable against: [:date, :title, :description]
  pg_search_scope( :search, 
                    against: [:date, :title, :description],
                    using: { tsearch: { prefix: true }} )
  
	has_many :attendances, as: :eventable
	has_many :attendees, through: :attendances
	has_many :committee_events, as: :eventable
	has_many :concerned_committees, through: :committee_events, class_name: "Committee"
	has_many :eventable_ordinances, as: :eventable
	has_many :considered_ordinances, through: :eventable_ordinances, class_name: "Ordinance"
	has_many :eventable_resolutions, as: :eventable
	has_many :considered_resolutions, through: :eventable_resolutions, class_name: "Resolution"

	has_many :documents, as: :documentable
end
