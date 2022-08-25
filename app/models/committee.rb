class Committee < ApplicationRecord
	include PgSearch::Model
	multisearchable against: [:current_name]
  pg_search_scope( :search, 
                    against: [:current_name],
                    using: { tsearch: { prefix: true }} )

	has_many :committee_members, dependent: :destroy
  has_many :committee_memberships, dependent: :destroy
  has_many :members, through: :committee_members

	has_many :authorships, as: :author, dependent: :destroy
	has_many :authored_ordinances, through: :authorships, source: :authorable, source_type: "Ordinance"
	has_many :authored_resolutions, through: :authorships, source: :authorable, source_type: "Resolution"

	has_many :sponsorships, as: :sponsor
	has_many :sponsored_ordinances, through: :sponsorships, source: :sponsorable, source_type: "Ordinance"
	has_many :sponsored_resolutions, through: :sponsorships, source: :sponsorable, source_type: "Resolution"

	has_many :committee_events
	has_many :committee_sessions, through: :committee_events, source: :eventable, source_type: "SpSession"
	has_many :committee_hearings, through: :committee_events, source: :eventable, source_type: "Hearing"
	has_many :committee_meetings, through: :committee_events, source: :eventable, source_type: "Meeting"

	def current_members
		current_membership.committee_members
	end

	def current_membership
		MembershipsFinder.new(termables: committee_memberships, date: Date.today).current
	end

	def to_s
		current_name
	end

	def name
		current_name
	end

	def signature
    [id, self.class.name].join(",")
  end

end
