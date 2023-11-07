class MunicipalOrdinance < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:number, :keyword]
  pg_search_scope( :search, 
                    against: [:number, :keyword],
                    using: { tsearch: { prefix: true }} )

  belongs_to :resolution
  belongs_to :municipality

  before_save :set_date_approved, :set_year_and_number, :set_year_series

  def self.query(args={})
    municipal_ordinance_finder(args).new(args.merge(municipal_ordinances: self)).query
  end

  private

  def set_date_approved
    self.date_approved = resolution.date_approved
  end

  def set_year_and_number
    self.year_and_number = number
  end

  def set_year_series
    self.year_series = number.split("-").first.to_i
  end
  
  def self.municipal_ordinance_finder(args={})
    default_finder = "MunicipalOrdinanceFinder::DefaultFinder"
    if args.present?
      klass = args.compact.map{ |key, value| value.present? ? key.to_s.titleize : nil }.join.gsub(" ", "")
    else
      klass = "DefaultFinder"
    end
    ("MunicipalOrdinanceFinder::#{klass}").constantize
    rescue NameError => e
      default_finder.constantize
  end
end
