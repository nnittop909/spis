module Imports
  class MemberTermsImporter
    require 'roo'
    include ActiveModel::Model

    attr_accessor :file

    def parse_records!
      member_terms_spreadsheet = Roo::Spreadsheet.open(file.path)
      header = member_terms_spreadsheet.row(1)
      (2..member_terms_spreadsheet.last_row).each do |i|
        row = Hash[[header, member_terms_spreadsheet.row(i)].transpose]
        ActiveRecord::Base.transaction do
          member = Member.find_by(code: row['SM_CODE'])
          term = Term.find_by(sm_code: row['SM_CODE'].to_i)
          if term.start_of_term.present? && term.end_of_term.present?
            member.terms.create!(
              start_of_term:      set_start_of_term(row),
              end_of_term:        set_end_of_term(row),
              sm_code:            row['SM_CODE'],
              appointment_status: term.appointment_status,
              position_id:        term.position.id,
              political_party_id: term.political_party.id
            )
          else
            term.update!(
              start_of_term: set_start_of_term(row),
              end_of_term:   set_end_of_term(row)
            )
          end
        end
      end
    end

    private

    def set_start_of_term(row)
      TermPeriodsCreator.new(code: row['TERM_CODE'].to_i).start_of_term
    end

    def set_end_of_term(row)
      TermPeriodsCreator.new(code: row['TERM_CODE'].to_i).end_of_term
    end

  end
end