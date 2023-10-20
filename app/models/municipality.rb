class Municipality < ApplicationRecord
	include PgSearch::Model
  multisearchable against: [:name]
  pg_search_scope( :search, 
                    against: [:name],
                    using: { tsearch: { prefix: true }} )
	has_many :municipal_ordinances

	def to_s
		name
	end
end
