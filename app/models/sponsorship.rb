class Sponsorship < ApplicationRecord
  belongs_to :sponsor, polymorphic: true
  belongs_to :sponsorable, polymorphic: true

  enum role: [:principal, :regular]

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
end
