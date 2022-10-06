class ResolutionProcessor
	include ActiveRecord::AttributeAssignment
	include ActiveModel::Model
	attr_accessor :number, :title, :date, :remarks,
			:category_id, :date_approved, :effectivity_date,
			:same_as_date_approved, :stage_id

	validates :number, :title, presence: true

	def process!
		if valid?
			ActiveRecord::Base.transaction do
				resolution = create_resolution
				create_stage(resolution)
			end
		end
	end

	private

	def create_resolution
		Resolution.create!(
			number:      number,
			title:       title,
			remarks:     remarks,
			date:        date,
			category_id: category_id
		)
	end

	def create_stage(resolution)
		resolution.stagings.create(
			date:             date_approved,
			effectivity_date: set_effectivity_date,
			stage_id:         stage_id
		)
	end

	def set_effectivity_date
		if same_as_date_approved == "1"
			date_approved
		else
			effectivity_date
		end
	end
end