module Imports
	class ResolutionDocumentsImporter
		include ActiveModel::Model

		attr_accessor :files

    def upload!
      ActiveRecord::Base.transaction do 
        files.each do |file|
          if file.present?
            file_name = file.original_filename.to_s.split(".").first
            original_file_name = file.original_filename.to_s.split("-").join("-")
            resolution = Resolution.where(number: file_name).last
            if resolution.present?
              resolution.create_document(
                name: file.original_filename.to_s,
                document_file: file
              )
            end
          end
        end
      end
    end
  end
end