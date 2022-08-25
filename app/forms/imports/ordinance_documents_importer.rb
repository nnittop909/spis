module Imports
	class OrdinanceDocumentsImporter
		include ActiveModel::Model

		attr_accessor :files

    def upload!
      ActiveRecord::Base.transaction do 
        files.each do |file|
          ordinance = Ordinance.find_by(number: file.filename)
          if ordinance.present?
            ordinance.documents.create(
              document_file: file
            )
          end
        end
      end
    end
  end
end