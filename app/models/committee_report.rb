class CommitteeReport < ApplicationRecord
  belongs_to :committee
  belongs_to :sp_session
  has_one_attached :document_file

  after_create :update_name!

  validates :document_file, blob: { content_type: 
    ["application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "application/pdf", "application/msword", "application/vnd.ms-excel", 
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"],
    size_range: 0.1..20.megabytes 
  }

  private
  def update_name!
    self.update!(name: document_file.filename)
  end
end
