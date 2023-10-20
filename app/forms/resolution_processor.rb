class ResolutionProcessor
	include ActiveRecord::AttributeAssignment
	include ActiveModel::Model
	attr_accessor :number, :title, :date, :remarks,
			:category_id, :date_approved, :effectivity_date,
			:same_as_date_approved, :stage_id, :municipality_id, :keyword,
			:ordinance_number

	validates :number, :title, presence: true
	validate :invalid_ordinance_number

	def process!
		if valid?
			ActiveRecord::Base.transaction do
				resolution = create_resolution
				create_stage(resolution)
				create_municipal_ordinance(resolution)
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

	def create_municipal_ordinance(resolution)
		resolution.create_municipal_ordinance(
			date_approved: date_approved,
			number: ordinance_number,
			year_series: parse_ordinance_number,
			year_and_number: ordinance_number,
			keyword: keyword.present? ? keyword : title,
			municipality_id: municipality_id
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

	def parse_ordinance_number
		ordinance_number.split("-").first.to_i
	end

	def invalid_ordinance_number
		if parse_ordinance_number.to_s.length != 4
			errors.add(:base, "Invalid Municipal Ordinance Number.")
		end
	end
end