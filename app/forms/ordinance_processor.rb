class OrdinanceProcessor
	include ActiveRecord::AttributeAssignment
	include ActiveModel::Model
	attr_accessor :number, :title, :date, :remarks, :committee_ids,
			:category_id, :member_ids, :documents

	validates :number, :title, presence: true

	def initialize(attr={})
		if !attr["id"].nil?
			@ordinance = Ordinance.find(attr["id"])
			self.number      = attr[:number].nil? ? @ordinance.number : attr[:number]
			self.title       = attr[:title].nil? ? @ordinance.title : attr[:title]
			self.date       = attr[:date].nil? ? @ordinance.date : attr[:date]
			self.remarks     = attr[:remarks].nil? ? @ordinance.remarks : attr[:remarks]
			self.category_id = attr[:category_id].nil? ? @ordinance.category_id : attr[:category_id]
			self.committee_ids = attr[:committee_ids].nil? ? @ordinance.committees.pluck(:id) : attr[:committee_ids]
			self.member_ids  = attr[:member_ids].nil? ? @ordinance.members.pluck(:id) : attr[:member_ids]
    else
      super(attr)
    end
  end

	def process!
		if valid?
			ActiveRecord::Base.transaction do
				ordinance = create_ordinance
				create_authors(ordinance)
				create_sponsors(ordinance)
			end
		end
	end

	def update!
		if valid?
			ActiveRecord::Base.transaction do
				update_ordinance
				create_authors(@ordinance)
				create_sponsors(@ordinance)
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
			category_id: category_id,
			documents: documents
		)
	end

	def update_ordinance
		@ordinance.update!(
			number:      number,
			title:       title,
			remarks:     remarks,
			date:        date,
			category_id: category_id
		)
	end

	def create_authors(ordinance)
		member_ids.reject(&:blank?).each do |author_id|
			ordinance.authorships.where(member_id: author_id).first_or_create(
				author_type: "co_author"
			)
		end
	end

	def create_sponsors(ordinance)
		committee_ids.reject(&:blank?).each do |sponsor_id|
			ordinance.sponsorships.where(committee_id: sponsor_id).first_or_create(
				sponsor_type: "secondary_sponsor"
			)
		end
	end
end