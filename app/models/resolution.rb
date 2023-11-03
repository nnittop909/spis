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

  has_many :stagings, as: :stageable, dependent: :destroy
  has_many :stages, through: :stagings
  has_many :documents, as: :documentable, dependent: :destroy
  has_one :municipal_ordinance

  enum current_stage: [:first_reading, :approved, :active_file]

  before_save :update_date_approved

  def self.categorize(category_name)
    if category_name == ""
      all
    else
      category_id = Category.find_by(name: category_name).id
      all.where(category_id: category_id)
    end
  end

  def authors
    member_authors + committee_authors
  end

  def sponsors
    member_sponsors + committee_sponsors
  end

  def current_staging
    stagings.order(:date).first
  end

  def date_adopted
    # CurrentStageFinder.new(stageable: self).date_dopted
    if current_staging.effectivity_date.present?
      current_staging.effectivity_date
    else
      current_staging.date
    end
  end

  def status
    # CurrentStageFinder.new(stageable: self).status
    stagings.present? ? current_staging.stage.name : ""
  end

  def parsed_number
    NumberParser.new(number: number).parse!
  end

  def self.query(args={})
    resolution_finder(args).new(args.merge(resolutions: self)).query
  end

  private

  def update_date_approved
    if municipal_ordinance.present?
      municipal_ordinance.update(date_approved: date_approved)
    end
  end
  
  def self.resolution_finder(args={})
    default_finder = "ResolutionFinder::DefaultFinder"
    if args.present?
      klass = args.compact.map{ |key, value| value.present? ? key.to_s.titleize : nil }.join.gsub(" ", "")
    else
      klass = "DefaultFinder"
    end
    ("ResolutionFinder::#{klass}").constantize
    rescue NameError => e
      default_finder.constantize
  end

end
