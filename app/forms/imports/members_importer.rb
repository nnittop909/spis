module Imports
	class MembersImporter
		require 'roo'
		include ActiveModel::Model

		attr_accessor :file

    def parse_records!
      members_spreadsheet = Roo::Spreadsheet.open(file.path)
      header = members_spreadsheet.row(1)
      (2..members_spreadsheet.last_row).each do |i|
        row = Hash[[header, members_spreadsheet.row(i)].transpose]
        ActiveRecord::Base.transaction do 
          member = Member.create! do |s|
            s.first_name                   = row['FIRST_NAME']
            s.last_name                    = row['LAST_NAME']
            s.middle_name                  = row['MID_INITIAL']
            s.name_suffix                  = row['NAME_SUFFIX']
            s.civil_status                 = set_civil_status(row)
            s.civil_service_eligibility_id = set_eligibility(row)
            s.educational_attainment_id    = 4
            s.code                         = row['SM_CODE'].to_i
            s.address                      = row['ADDRESS']
          end
          create_term(member, row)
        end
      end
    end

    def set_civil_status(row)
      case row['CS_CODE'].to_i
      when 1
        "single"
      when 2
        "married"
      when 3
        "widowed"
      when 4
        "divorced"
      else
        "single"
      end
    end

    def create_term(member, row)
      if member.terms.blank?
        member.terms.create!(
          sm_code:            row['SM_CODE'].to_i,
          political_party_id: set_party_code(row),
          position_id:        set_position(row), 
          appointment_status: set_appointment_status(row)
        )
      end
    end

    def set_position(row)
      case row['POS_CODE'].to_i
      when 12
        11
      when 13
        12
      else
        row['POS_CODE'].to_i
      end
    end

    def set_appointment_status(row)
      case row['AS_CODE'].to_i
      when 1
        "elective"
      else
        "appointive"
      end
    end

    def set_eligibility(row)
      case row['CSE_CODE'].to_i
      when 1 #Master
        2
      when 2 #PhD
        3
      when 3 #Bachelor
        1
      else
        1
      end        
    end

    def set_party_code(row)
      case row['PARTY_CODE'].to_i
      when 1
        1
      when 2
        6
      when 3
        2
      else
        2
      end
    end
  end
end