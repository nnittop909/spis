class Member < ApplicationRecord
	include PgSearch::Model
  multisearchable against: [:full_name, :first_name, :last_name]
  pg_search_scope( :search, 
                    against: [:full_name, :first_name, :last_name],
                    using: { tsearch: { prefix: true }} )

	has_many :terms, as: :termable
	has_many :positions, through: :terms
	has_many :political_parties, through: :terms
	has_many :salary_adjustments
	has_many :step_increments
	has_one :community_tax, dependent: :destroy

	has_many :committee_members, dependent: :destroy
	has_many :committee_memberships, through: :committee_members
	has_many :committees, through: :committee_members

	has_many :authorships, as: :author, dependent: :destroy
	has_many :authored_ordinances, through: :authorships, source: :authorable, source_type: "Ordinance"
	has_many :authored_resolutions, through: :authorships, source: :authorable, source_type: "Resolution"

	has_many :sponsorships, as: :sponsor
	has_many :sponsored_ordinances, through: :sponsorships, source: :sponsorable, source_type: "Ordinance"
	has_many :sponsored_resolutions, through: :sponsorships, source: :sponsorable, source_type: "Resolution"

	has_one_attached :avatar
	has_one_attached :service_oath

	belongs_to :civil_service_eligibility
	belongs_to :educational_attainment

	enum civil_status: [:single, :married, :divorced, :separated, :widowed], _suffix: :status

	validates :avatar, blob: { 
    content_type: ['image/jpg', 'image/jpeg', 'image/png'], 
    size_range: 0.1..3.megabytes 
  }

  validates :service_oath, blob: { content_type: 
    ["application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "application/pdf", "application/msword", "application/vnd.ms-excel", 
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"],
    size_range: 0.1..20.megabytes 
  }

  validates :first_name, :last_name, :middle_name, presence: true

  before_save :set_full_name, :set_default_avatar

  def to_s
    full_name
  end

  def name
    full_name
  end

  def reversed_name
    array = [first_name, middle_name.blank? ? nil : "#{middle_name.first.upcase}.", name_suffix].compact
    "#{last_name}, #{array.join(" ")}"
  end

  def name_in_honorifics
  	"HON. #{name.upcase}"
  end

  def latest_term
    if terms.where.not(start_of_term: nil).present?
      terms.where.not(start_of_term: nil).order(:start_of_term).last
    end
  end

  def current_term
  	TermFinder.new(termable: self).current_term
  end

  def current_term_in_years
  	TermFinder.new(termable: self).current_term_in_years
  end

  def current_salary_adjustment
    salary_adjustments.order(:effectivity_date).last
  end

  def current_step_increment
    step_increments.order(:effectivity_date).last
  end

  def by_term_in_years(year)
  	TermFinder.new(termable: self, year: year).by_term_in_years
  end

  def current_position
  	TermFinder.new(termable: self).current_position
  end

  def by_term_position(year)
  	TermFinder.new(termable: self, year: year).by_term_position
  end

  def current_party
  	TermFinder.new(termable: self).current_party
  end

  def by_term_party(year)
  	TermFinder.new(termable: self, year: year).by_term_party
  end

  def current_appointment_status
  	TermFinder.new(termable: self).current_appointment_status
  end

  def by_term_appointment_status(year)
  	TermFinder.new(termable: self, year: year).by_term_appointment_status
  end

  def with_consecutive_terms?
  	ConsecutiveTermFinder.new(termable: self).with_consecutive_terms?
  end

  def consecutive_terms
  	ConsecutiveTermFinder.new(termable: self).consecutive_terms
  end

  def consecutive_terms_count
  	ConsecutiveTermFinder.new(termable: self).count!
  end

  def salary_adjustable_terms
  	ConsecutiveTermFinder.new(termable: self).second_term 
  end

  def terms_as_board_member
    board_member_position_ids = positions.as_board_member.pluck(:id)
    terms.where(position_id: board_member_position_ids)
  end

  def consecutive_terms_as_board_member
    board_member_position_ids = positions.as_board_member.pluck(:id)
    terms.where(id: consecutive_terms.pluck(:id)).where(position_id: board_member_position_ids)
  end

  def fullname
  	if middle_name.present? && name_suffix.present?
    	"#{first_name} #{middle_name.first.upcase}. #{last_name} #{name_suffix}"
    elsif middle_name.present?
    	"#{first_name} #{middle_name.first.upcase}. #{last_name}"
    else
    	"#{first_name} #{last_name}"
    end
  end

  def signature
    [id, self.class.name].join(",")
  end

  private

  def set_full_name
    self.full_name = fullname
  end

  def set_default_avatar
  	if !avatar.attached?
      avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.png')), filename: 'default-avatar.png', content_type: 'image/png')
    end
  end

end
