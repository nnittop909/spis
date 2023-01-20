class CommitteeProcessor
	include ActiveRecord::AttributeAssignment
	include ActiveModel::Model
	attr_accessor :name, :start_of_term, :end_of_term, :active

	validates :name, presence: true

	def initialize(attr={})
		if !attr["id"].nil?
			@committee         = Committee.find(attr["id"])
			@committee_membership = @committee.current_membership
			self.name          = attr[:name].nil? ? @committee_membership.name : attr[:name]
			self.start_of_term = attr[:start_of_term].nil? ? @committee_membership.start_of_term : attr[:start_of_term]
			self.end_of_term   = attr[:end_of_term].nil? ? @committee_membership.end_of_term : attr[:end_of_term]
			self.active        = attr[:active].nil? ? @committee_membership.active : attr[:active]
    else
      super(attr)
    end
  end

	def process!
		if valid?
			ActiveRecord::Base.transaction do
				committee = create_committee
				create_committee_membership(committee)
			end
		end
	end

	def update!
		if valid?
			ActiveRecord::Base.transaction do
				unset_active_terms_if_params_active_true
				update_committee_membership
				set_current_committee_if_params_active
			end
		end
	end

	private

	def create_committee
		Committee.create!(
			current_name:          name,
			current_start_of_term: start_of_term,
			current_end_of_term:   end_of_term
		)
	end

	def create_committee_membership(committee)
		committee.committee_memberships.create(
			name:          name,
			start_of_term: start_of_term,
			end_of_term:   end_of_term,
			active:        true
		)
	end

	def update_committee_membership
		@committee_membership.update!(
			name:          name,
			start_of_term: start_of_term,
			end_of_term:   end_of_term,
			active:        set_active_value_on_update
		)
		
	end

	def set_current_committee_if_params_active
		if active
			@committee.update!(
				current_name:          name,
				current_start_of_term: start_of_term,
				current_end_of_term:   end_of_term
			)
		end
	end

	def unset_active_terms_if_params_active_true
		if active
			if @committee.committee_memberships.count > 1
				@committee.committee_memberships.each do |term|
					term.update!(active: false)
				end
			end
		end
	end

	def set_active_value_on_update
		if @committee.committee_memberships.count > 1
			active
		else
			true
		end
	end
end