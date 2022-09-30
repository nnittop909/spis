module Imports
	class ResolutionsImporter
		require 'roo'
		include ActiveModel::Model

		attr_accessor :file

    def parse_records!
      resolutions_spreadsheet = Roo::Spreadsheet.open(file.path)
      header = resolutions_spreadsheet.row(1)
      (2..resolutions_spreadsheet.last_row).each do |i|
        row = Hash[[header, resolutions_spreadsheet.row(i)].transpose]
        ActiveRecord::Base.transaction do 
          resolution = Resolution.where(code: row['RES_CODE']).where(number: parse_number(row)).first_or_create! do |o|
            o.title         = row['TITLE']
            o.date          = row['DATE_CALENDARED']
            o.remarks       = row['REMARKS']
            o.current_stage = set_stage(row)
            o.category_id   = row['CAT_CODE']
          end
          create_stages(resolution, row)
        end
      end
    end

    def create_stages(resolution, row)
      first_reading = Stage.find_by(alias_name: "first_reading")
      second_reading_approved = Stage.find_by(alias_name: "approved_on_second_reading")
      active_file = Stage.find_by(alias_name: "active_file")
      
      if row['DATE_APPROVED'].present?
        resolution.stagings.create!(
          date:             Date.parse(row['DATE_APPROVED'].to_s),
          effectivity_date: row['DATE_ADOPTED'].present? ? Date.parse(row['DATE_ADOPTED'].to_s) : nil,
          stage_id:         second_reading_approved.id
        )
      end

    end

    def parse_number(row)
      NumberParser.new(number: row['NUMBER']).parse_for_importing_resolution!
    end

    def set_stage(row)
      case row['STAGE_CODE']
      when 1
        "first_reading"
      when 7
        "approved"
      else
        "active_file"
      end
    end
  end
end