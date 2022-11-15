class Minute < ApplicationRecord
	include PgSearch::Model
  multisearchable against: [:title]
  pg_search_scope( :search, 
                    against: [:title],
                    using: { tsearch: { prefix: true }} )

  has_one_attached :file, dependent: :destroy

  enum minute_type: [:session, :hearing, :meeting]

  validates :date, :title, :minute_type, presence: true
  validates :file, blob: { content_type: 
    ["application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "application/pdf", "application/msword", "application/vnd.ms-excel", 
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"],
    size_range: 0.1..100.megabytes 
  }

  def self.query(args={})
    minute_finder(args).new(args.merge(minutes: self)).query
  end

  private
  
  def self.minute_finder(args={})
    default_finder = "MinuteFinder::DefaultFinder"
    if args.present?
      klass = args.compact.map{ |key, value| value.present? ? key.to_s.titleize : nil }.join.gsub(" ", "")
    else
      klass = "DefaultFinder"
    end
    ("MinuteFinder::#{klass}").constantize
    rescue NameError => e
      default_finder.constantize
  end
end
