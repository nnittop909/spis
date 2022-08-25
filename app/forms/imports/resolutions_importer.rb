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
          ordinance = Resolution.where(code: row['RES_CODE']).where(number: parse_number(row)).first_or_create! do |o|
            o.title         = row['TITLE']
            o.date          = row['DATE_CALENDARED']
            o.remarks       = row['REMARKS']
            o.current_stage = set_stage(row)
            o.category_id   = row['CAT_CODE']
          end
          create_stages(ordinance, row)
        end
      end
    end

    def create_stages(ordinance, row)
      first_reading = Stage.find_by(name: "First Reading", phase: 0)
      second_reading = Stage.find_by(name: "Second Reading", phase: 1)
      third_reading_disapproved = Stage.find_by(name: "Disapproved on Third Reading", phase: 2)
      for_deliberation = Stage.find_by(name: "For Deliberation", phase: 2)
      third_reading_approved = Stage.find_by(name: "Approved on Third Reading", phase: 2)
      lce_vetoed = Stage.find_by(name: "Vetoed by the LCE", phase: 3)
      lce_approved = Stage.find_by(name: "Approved by the LCE", phase: 3)
      amended = Stage.find_by(name: "Amended", phase: 4)
      
      if row['DATE_APPROVED'].present?
        ordinance.stagings.create!(
          date:             Date.parse(row['DATE_APPROVED'].to_s),
          effectivity_date: row['DATE_ADOPTED'].present? ? Date.parse(row['DATE_ADOPTED'].to_s) : nil,
          stage_id:         lce_approved.id,
        )
      end

    end

    def parse_number(row)
    	row['NUMBER'].split("-").join("-")
    end

    def set_stage(row)
      case row['STAGE_CODE']
      when 1
        "first_reading"
      when 2
        "second_reading"
      when 3
        "disapproved_on_third_reading"
      when 4
        "for_deliberation"
      when 5
        "approved_on_third_reading"
      when 6
        "vetoed"
      when 7
        "approved"
      else
        "ammended"
      end
    end
  end
end