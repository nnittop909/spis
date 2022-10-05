module Merges
	class CommitteeMerger
		include ActiveModel::Model
		attr_accessor :merge_from_id, :merge_to_id

		validates :merge_from_id, :merge_to_id, presence: true
		validate :similar_merging_ids

		def merge!
			if valid?
				ActiveRecord::Base.transaction do
					merge_memberships
					merge_members
					merge_ordinances
					merge_resolutions
					destroy_committee
				end
			end
		end

		private

		def destroy_committee
			find_merge_from_committee.destroy
		end

		def merge_memberships
			find_merge_from_committee.committee_memberships.each do |cm|
				cm.update!(committee_id: find_merge_to_committee.id)
			end
		end

		def merge_members
			find_merge_from_committee.committee_members.each do |cm|
				cm.update!(committee_id: find_merge_to_committee.id)
			end
		end

		def merge_ordinances
			if find_merge_from_committee.sponsorships.where(sponsorable_type: "Ordinance").present?
				find_merge_from_committee.sponsorships.where(sponsorable_type: "Ordinance").each do |s|
					s.update!(
						sponsor_id: find_merge_to_committee.id,
						sponsor_type: find_merge_to_committee.class.name
					)
				end
			end
		end

		def merge_resolutions
			if find_merge_from_committee.sponsorships.where(sponsorable_type: "Resolution").present?
				find_merge_from_committee.sponsorships.where(sponsorable_type: "Resolution").each do |s|
					s.update!(
						sponsor_id: find_merge_to_committee.id,
						sponsor_type: find_merge_to_committee.class.name
					)
				end
			end
		end

		def find_merge_from_committee
			Committee.find(merge_from_id)
		end

		def find_merge_to_committee
			Committee.find(merge_to_id)
		end

		def similar_merging_ids
			if merge_from_id.present? && merge_to_id.present?
				if merge_from_id == merge_to_id
					errors.add(:base, "Unable to merge the same committee.")
				end
			end
		end
	end
end