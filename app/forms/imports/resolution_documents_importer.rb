module Imports
	class ResolutionDocumentsImporter
		include ActiveModel::Model

		attr_accessor :files

    def upload!
      ActiveRecord::Base.transaction do 
        files.each do |file|
          if file.present?
            file_name = file.original_filename.to_s.split(".").first
            parsed_file_name = FilenameParser.new(filename: file_name).parse!
            resolution = Resolution.find_by(number: parsed_file_name)
            if resolution.present?
              document = resolution.documents.where(name: parsed_file_name).first_or_create! do |d|
                d.document_file = file
              end
              document.update(name: "PR-#{parsed_file_name}")
            end
          end
        end
      end
    end

  end
end