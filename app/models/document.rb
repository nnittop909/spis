class Document < ApplicationRecord
  multisearchable against: [:name]
  pg_search_scope( :search, 
                    against: [:name],
                    using: { tsearch: { prefix: true }} )

  belongs_to :documentable, polymorphic: true
  has_one_attached :document_file

  after_create :update_name!

  validates :document_file, blob: { content_type: 
    ["application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "application/pdf", "application/msword", "application/vnd.ms-excel", 
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"],
    size_range: 0.1..200.megabytes 
  }

  private

  def update_name!
    self.update!(name: document_file.filename) if name.blank? && document_file.present?
  end
end
