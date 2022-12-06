class Searchable
	attr_accessor :search

	def initialize(args={})
		@search = args[:search]
	end

	def results
		PgSearch.multisearch(search).where(searchable_type: ["Member", "Committee", "Ordinance", "Resolution", "Document", "Minute"])
		# posts = Post.where(id: ids).order(created_at: :desc)
		# projects = Project.where(id: ids).order(created_at: :desc)
		# plans = Plan.where(id: ids).order(created_at: :desc)
		# downloadables = Downloadable.where(id: ids).order(created_at: :desc)
		# reports = Report.where(id: ids).order(created_at: :desc)
		# posts + projects + reports + downloadables + plans
	end
end