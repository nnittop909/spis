class Ordinance < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:number, :title]
  pg_search_scope( :search, 
                    against: [:number, :title],
                    using: { tsearch: { prefix: true }} )

  belongs_to :category
  has_many :eventable_ordinances
  has_many :considered_ordinances, through: :eventable_ordinances

  has_many :authorships, as: :authorable, dependent: :destroy
  has_many :member_authors, through: :authorships, source: :author, source_type: "Member"
  has_many :committee_authors, through: :authorships, source: :author, source_type: "Committee"

  has_many :sponsorships, as: :sponsorable, dependent: :destroy
  has_many :member_sponsors, through: :sponsorships, source: :sponsor, source_type: "Member"
  has_many :committee_sponsors, through: :sponsorships, source: :sponsor, source_type: "Committee"

  has_many :stagings, as: :stageable
  has_many :stages, through: :stagings
  has_one :document, as: :documentable, dependent: :destroy

  enum current_stage: [:first_reading, :second_reading, :disapproved_on_third_reading, 
    :for_deliberation, :approved_on_third_reading, :vetoed, :approved, :ammended]

  def authors
    member_authors + committee_authors
  end

  def sponsors
    member_sponsors + committee_sponsors
  end

  def date_approved
    CurrentStageFinder.new(stageable: self).date_approved
  end

  def status
    CurrentStageFinder.new(stageable: self).status
  end

  def parsed_number
    NumberParser.new(number: number).parse!
  end

  
end
