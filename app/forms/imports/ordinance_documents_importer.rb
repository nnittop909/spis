module Imports
	class OrdinanceDocumentsImporter
		include ActiveModel::Model

		attr_accessor :files

    def upload!
      ActiveRecord::Base.transaction do 
        files.each do |file|
          if file.present?
            file_name = file.original_filename.to_s.split(".").first
            original_file_name = file.original_filename.to_s.split("-").join("-")
            ordinance = Ordinance.where(number: parsed_filename(file_name)).last
            if ordinance.present?
              ordinance.create_document(
                name: "#{parsed_filename(file_name)}.pdf",
                document_file: file
              )
            end
          end
        end
      end
    end

    def parsed_filename(file_name)
      FilenameParser.new(filename: file_name).parse!
    end
  end
end