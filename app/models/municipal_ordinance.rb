class MunicipalOrdinance < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:year_and_number, :keyword]
  pg_search_scope( :search, 
                    against: [:year_and_number, :keyword],
                    using: { tsearch: { prefix: true }} )

  belongs_to :resolution
  belongs_to :municipality

  def self.query(args={})
    municipal_ordinance_finder(args).new(args.merge(municipal_ordinances: self)).query
  end

  private
  
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
