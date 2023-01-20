class Sponsorship < ApplicationRecord
  belongs_to :sponsor, polymorphic: true
  belongs_to :sponsorable, polymorphic: true

  enum role: [:principal, :regular]
  validates :role, :sponsor_id, presence: true
  validate :duplicated_sponsors

  def polymorphic_member_sponsors
    Member.order(:first_name).all
  end

  def polymorphic_committee_sponsors
    Committee.order(:current_name).all
  end

  # def polymorphic_sponsor
  #   self.author.to_global_id(expires_in: nil) if self.author.present?
  # end

  def polymorphic_sponsor=(value)
    self.author = GlobalID::Locator.locate_signed(value, for: :polymorphic_select)
  end

  private
  def duplicated_sponsors
    if sponsorable.sponsorships.where(sponsor_id: sponsor_id).present?
      errors.add(:sponsor_id, "already exists, please change!")
    end
  end
end
