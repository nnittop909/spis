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

  has_many :stagings, as: :stageable, dependent: :destroy
  has_many :stages, through: :stagings
  has_many :documents, as: :documentable, dependent: :destroy

  enum current_stage: [:first_reading, :second_reading, :disapproved_on_third_reading, 
    :for_deliberation, :approved_on_third_reading, :vetoed, :approved, :deemed_approved, :ammended]
  
  def authors
    member_authors + committee_authors
  end

  def sponsors
    member_sponsors + committee_sponsors
  end

  def date_enacted
    # CurrentStageFinder.new(stageable: self).date_enacted
    if current_staging.effectivity_date.present?
      current_staging.effectivity_date
    else
      current_staging.date
    end
  end

  def status
    # CurrentStageFinder.new(stageable: self).status
    stagings.present? ? current_staging.stage.name : nil
  end

  def current_staging
    stagings.order(:date).first
  end

  def parsed_number
    NumberParser.new(number: number).parse!
  end

  def parse_to_date_range(year)
    ("01-01-#{year}").to_date..("12-31-#{year}").to_date
  end

  def self.query(args={})
    ordinance_finder(args).new(args.merge(ordinances: self)).query
  end

  private
  
  def self.ordinance_finder(args={})
    default_finder = "OrdinanceFinder::DefaultFinder"
    if args.present?
      klass = args.compact.map{ |key, value| value.present? ? key.to_s.titleize : nil }.join.gsub(" ", "")
    else
      klass = "DefaultFinder"
    end
    ("OrdinanceFinder::#{klass}").constantize
    rescue NameError => e
      default_finder.constantize
  end

end
