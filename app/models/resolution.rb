class Resolution < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:number, :title]
  pg_search_scope( :search, 
                    against: [:number, :title],
                    using: { tsearch: { prefix: true }} )

  belongs_to :category

  has_many :authorships, as: :authorable, dependent: :destroy
  has_many :member_authors, through: :authorships, source: :author, source_type: "Member"
  has_many :committee_authors, through: :authorships, source: :author, source_type: "Committee"

  has_many :sponsorships, as: :sponsorable, dependent: :destroy
  has_many :member_sponsors, through: :sponsorships, source: :sponsor, source_type: "Member"
  has_many :committee_sponsors, through: :sponsorships, source: :sponsor, source_type: "Committee"

  has_many :stagings, as: :stageable
  has_many :stages, through: :stagings
  has_many :documents, as: :documentable

  enum current_stage: [:first_reading, :second_reading, :disapproved_on_third_reading, 
    :for_deliberation, :approved_on_third_reading, :vetoed, :approved, :ammended]

  def authors
    member_authors + committee_authors
  end

  def sponsors
    member_sponsors + committee_sponsors
  end

  def date_approved_or_adopted
    CurrentStageFinder.new(stageable: self).date_approved_or_enacted
  end

  def joined_number
    number.split("-").join("").to_i
  end
end
