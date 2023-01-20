module Imports
	class MembershipsImporter
		require 'roo'
		include ActiveModel::Model

		attr_accessor :file

    def parse_records!
      committee_memberships_spreadsheet = Roo::Spreadsheet.open(file.path)
      header = committee_memberships_spreadsheet.row(1)
      (2..committee_memberships_spreadsheet.last_row).each do |i|
        row = Hash[[header, committee_memberships_spreadsheet.row(i)].transpose]
        ActiveRecord::Base.transaction do 
          committee_membership = CommitteeMembership.where(committee_id: find_committee(row).id).where(start_of_term: set_start_of_term(row)).first_or_create! do |c|
            c.name          = find_committee(row).try(:current_name)
            c.end_of_term   = set_end_of_term(row)
            c.active        = false
          end
          set_members(committee_membership, row)
        end
      end
      set_active_membership
    end

    private

    def set_start_of_term(row)
      TermPeriodsCreator.new(code: row['TERM_CODE']).start_of_term
    end

    def set_end_of_term(row)
      TermPeriodsCreator.new(code: row['TERM_CODE']).end_of_term
    end

    def set_members(committee_membership, row)
      if find_member(row).present?
        CommitteeMember.create!(
          role:                    set_role(row),
          committee_id:            find_committee(row).id,
          committee_membership_id: committee_membership.id,
          member_id:               find_member(row).id
        )
      end
    end

    def find_member(row)
      Member.find_by(code: row['SM_CODE'])
    end

    def find_committee(row)
      Committee.find_by(code: row['SC_CODE'])
    end

    def set_role(row)
      case row['MEMBER_TYPE'].to_i
      when 1
        "chairperson"
      when 2
        "vice_chairperson"
      when 3
        "regular"
      end
    end

    def set_active_membership
      latest_memberships.each do |membership|
        membership.update!(active: true)
      end
    end

    def latest_memberships
      MembershipsFinder.new(termables: CommitteeMembership.all, date: Date.today).query!
    end
  end
end