module Imports
	class ResolutionAuthorsImporter
		require 'roo'
		include ActiveModel::Model

		attr_accessor :file

    def parse_records!
      authors_spreadsheet = Roo::Spreadsheet.open(file.path)
      header = authors_spreadsheet.row(1)
      (2..authors_spreadsheet.last_row).each do |i|
        row = Hash[[header, authors_spreadsheet.row(i)].transpose]
        ActiveRecord::Base.transaction do 
          resolution = find_resolution(row)
          if find_member(row).present?
            resolution.authorships.where(author_id: find_member(row).id).where(author_type: find_member(row).class.name).first_or_create! do |a|
              a.role = set_author_type(row)
            end
          end
        end
      end
    end

    def find_member(row)
      Member.where(first_name: row['FIRST_NAME']).where(last_name: row['LAST_NAME']).where(middle_name: row['MID_INITIAL']).where(name_suffix: row['NAME_SUFFIX']).first
    end

    def find_resolution(row)
      Resolution.find_by(code: row['RES_CODE'])
    end

    def set_author_type(row)
      case row['AUTHOR_TYPE']
      when 1
        "author"
      else
        "co_author"
      end
    end
  end
end