module Ordinances
	class AuthorProcessor

		include ActiveModel::Model
		attr_accessor :role, :ordinance_id, :member_ids

		validates :member_ids, presence: true

		def initialize(attr={})
			@role = attr[:role]
			@ordinance_id = attr[:ordinance_id]
			@member_ids = attr[:member_ids]
	  end

	  def process!
	  	if valid?
				ActiveRecord::Base.transaction do
					create_authorships
				end
			end
	  end

	  private

	  def create_authorships
	  	find_members.each do |member|
	  		find_ordinance.authorships.create(
	  			role: @role,
	  			author: member
	  		)
	  	end
	  end

	  def find_ordinance
	  	Ordinance.find(ordinance_id)
	  end

	  def find_members
	  	Member.where(id: member_ids)
	  end
	end
end