class OrdinanceProcessor
	include ActiveRecord::AttributeAssignment
	include ActiveModel::Model
	attr_accessor :number, :title, :date, :remarks,
			:category_id, :date_approved, :effectivity_date,
			:same_as_date_approved, :stage_id

	validates :number, :title, :date, presence: true

	def process!
		if valid?
			ActiveRecord::Base.transaction do
				ordinance = create_ordinance
				create_stage(ordinance)
			end
		end
	end

	private

	def create_ordinance
		Ordinance.create!(
			number:      number,
			title:       title,
			remarks:     remarks,
			date:        date,
			category_id: category_id
		)
	end

	def create_stage(ordinance)
		ordinance.stagings.create(
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