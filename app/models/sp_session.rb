class SpSession < ApplicationRecord
	include PgSearch::Model
  multisearchable against: [:date, :title, :description]
  pg_search_scope( :search, 
                    against: [:date, :title, :description],
                    using: { tsearch: { prefix: true }} )
  
	has_many :attendances, as: :eventable
	has_many :attendees, through: :attendances
	
	has_many :committee_events, as: :eventable
	has_many :concerned_committees, through: :committee_events, source: :committee

	has_many :eventable_ordinances, as: :eventable
	has_many :considered_ordinances, through: :eventable_ordinances, source: :ordinance

	has_many :eventable_resolutions, as: :eventable
	has_many :considered_resolutions, through: :eventable_resolutions, source: :resolution

	has_many :committee_reports
	has_many :documents, as: :documentable
	has_one_attached :file
	has_one_attached :signatory_file

	enum event_type: [:special, :regular]

	before_save :set_title, :set_description

	private

	def set_title
		self.title = "#{event_number.ordinalize} #{event_type.titleize} Session"
	end

	def set_description
		self.description = "#{event_number.ordinalize} #{event_type.titleize} Session of the #{Office.last.current_term.ordinal_number}#{Office.last.current_term.ordinal} Sanguniang Panlalawigan"
	end
end
