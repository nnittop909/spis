module Imports
	class OrdinanceSponsorsImporter
		require 'roo'
		include ActiveModel::Model

		attr_accessor :file

    def parse_records!
      sponsors_spreadsheet = Roo::Spreadsheet.open(file.path)
      header = sponsors_spreadsheet.row(1)
      (2..sponsors_spreadsheet.last_row).each do |i|
        row = Hash[[header, sponsors_spreadsheet.row(i)].transpose]
        ActiveRecord::Base.transaction do 
          ordinance = find_ordinance(row)
          if find_sponsor(row).present?
            ordinance.sponsorships.where(sponsor_id: find_sponsor(row).id).where(sponsor_type: find_sponsor(row).class.name).first_or_create! do |a|
              a.role = "principal"
            end
          end
        end
      end
    end

    def find_sponsor(row)
      Committee.find_by(code: row['SC_CODE'])
    end

    def find_ordinance(row)
      Ordinance.find_by(code: row['ORD_CODE'])
    end
  end
end