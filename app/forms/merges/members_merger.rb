module Merges
	class MembersMerger
		include ActiveModel::Model
		attr_accessor :mergeables

		def merge!
			if valid?
				ActiveRecord::Base.transaction do
					merge_members
				end
			end
		end

		def merge_members
			duplicated_full_names = Member.select(:full_name).group(:full_name).having("count(*) > 1").to_a.pluck(:full_name)
			duplicated_full_names.each do |full_name|
				merge_to_member = find_merge_to_member(full_name)
				merge_from_members = find_merge_from_members(full_name)
				merge_from_members.each do |merge_from_member|
					if merge_from_member.terms.present?
						merge_from_member.terms.each do |term|
							term.update!(termable: merge_to_member)
						end
						merge_from_member.destroy
					end
				end
			end
		end

		def dupplicated
			duplicated_full_names = Member.select(:full_name).group(:full_name).having("count(*) > 1").to_a
		end

		private

		def find_merge_to_member(full_name)
			Member.where(full_name: full_name).order(:id).first
		end

		def find_merge_from_members(full_name)
			Member.where(full_name: full_name) - [find_merge_to_member(full_name)]
		end
	end
end