module Imports
	class CommitteesImporter
		require 'roo'
		include ActiveModel::Model

		attr_accessor :file

    def parse_records!
      committees_spreadsheet = Roo::Spreadsheet.open(file.path)
      header = committees_spreadsheet.row(1)
      (2..committees_spreadsheet.last_row).each do |i|
        row = Hash[[header, committees_spreadsheet.row(i)].transpose]
        ActiveRecord::Base.transaction do 
          committee = Committee.where(current_name: row['NAME']).where(code: row['SC_CODE']).first_or_create!
        end
      end
    end
  end
end