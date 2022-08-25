module Committees
	class TermProcessor
		include ActiveRecord::AttributeAssignment
		include ActiveModel::Model
		attr_accessor :name, :start_of_term, :end_of_term, :active, :committee_id

  	validate :overlapping_terms, on: :create
		validates :name, presence: true

		def initialize(attr={})
			if !attr["id"].nil?
				@committee_membership = CommitteeMembership.find(attr["id"])
				self.name          = attr[:name].nil? ? @committee_membership.name : attr[:name]
				self.start_of_term = attr[:start_of_term].nil? ? @committee_membership.start_of_term : attr[:start_of_term]
				self.end_of_term   = attr[:end_of_term].nil? ? @committee_membership.end_of_term : attr[:end_of_term]
				self.active        = attr[:active].nil? ? @committee_membership.active : attr[:active]
				self.committee_id  = attr[:committee_id].nil? ? @committee_membership.committee_id : attr[:committee_id]
	    else
	      super(attr)
	    end
	  end

		def process!
			if valid?
				ActiveRecord::Base.transaction do
					unset_active_terms_if_params_active_true
					create_term
					update_committee_if_params_active_true
				end
			end
		end

		def update!
			if valid?
				ActiveRecord::Base.transaction do
					unset_active_terms_if_params_active_true
					update_term
					update_committee_if_params_active_true
				end
			end
		end

		def delete!
			if valid?
				ActiveRecord::Base.transaction do
					unset_active_terms_if_params_active_true
					delete_term
					update_committee_if_params_active_true
				end
			end
		end

		private

		def create_term
			find_committee.committee_memberships.create!(
				name:          name,
				start_of_term: start_of_term,
				end_of_term:   end_of_term,
				active:       active
			)
		end

		def unset_active_terms_if_params_active_true
			if active
				find_committee.committee_memberships.each do |term|
					term.update!(active: false)
				end
			end
		end

		def update_term
			@committee_membership.update!(
				name:          name,
				start_of_term: start_of_term,
				end_of_term:   end_of_term,
				active:       active
			)
		end

		def update_committee_if_params_active_true
			if active
				find_committee.update!(
					current_name:          name,
					current_start_of_term: start_of_term,
					current_end_of_term:   end_of_term
				)
			end
		end

		def delete_term
			@committee_membership.destroy
		end

		def find_committee
			committee = Committee.find(committee_id)
		end

	  def term_overlap_validator
	    TermOverlapValidator.new(
	      validatable_start_date: start_of_term.values.to_a.join("-").to_date,
	      validatable_end_date: end_of_term.values.to_a.join("-").to_date,
	      termable: find_committee
	    )
	  end

	  def overlapped_terms
	    term_overlap_validator.overlapped_terms
	  end

	  def overlapping_terms
	    if start_of_term.present? && end_of_term.present? 
	      if overlapped_terms.present?
	        errors.add(:base, term_overlap_validator.error_message)
	      end
	    end
	  end
	end
end