class Authorship < ApplicationRecord
  belongs_to :author, polymorphic: true
  belongs_to :authorable, polymorphic: true

  enum role: [:author, :co_author]
  validates :role, :author_id, presence: true
  validate :duplicated_authors
  delegate :name, :name_in_honorifics, to: :author, prefix: true

  def polymorphic_member_authors
    Member.order(:first_name).all
  end

  def polymorphic_committee_authors
    Committee.order(:current_name).all
  end

  # def polymorphic_author
  #   self.author.to_global_id(expires_in: nil) if self.author.present?
  # end

  def polymorphic_author=(value)
    self.author = GlobalID::Locator.locate_signed(value, for: :polymorphic_select)
  end

  private
  def duplicated_authors
    if authorable.authorships.where(author_id: author_id).present?
      errors.add(:author_id, "already exists, please change!")
    end
  end
end
