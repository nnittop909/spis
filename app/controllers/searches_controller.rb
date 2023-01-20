class SearchesController < ApplicationController
	
	def index
		#PgSearch.multisearch(params[:search]).where(searchable_type: "Project") -> filtering search
		@results = PgSearch.multisearch(params[:search])
		@file_results = ActiveStorage::Blob.where("lower(filename) like ?", "%#{params[:search].downcase}%")
		@records = Kaminari.paginate_array(@results + @file_results).page(params[:page]).per(30)
	end

end