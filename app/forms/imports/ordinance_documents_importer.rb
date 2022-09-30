module Imports
	class OrdinanceDocumentsImporter
		include ActiveModel::Model

		attr_accessor :files

    def upload!
      ActiveRecord::Base.transaction do 
        files.each do |file|
          if file.present?
            file_name = file.original_filename.to_s.split(".").first
            parsed_file_name = FilenameParser.new(filename: file_name).parse!
            ordinance = Ordinance.find_by(number: parsed_file__name)
            if ordinance.present?
              document = ordinance.documents.where(name: "#{parsed_file_name}.pdf").first_or_create! do |d|
                d.document_file = file
              end
              document.update(name: "PO-#{parsed_file_name}.pdf")
            end
          end
        end
      end
    end
  end
end