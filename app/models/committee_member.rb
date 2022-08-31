class CommitteeMember < ApplicationRecord
  belongs_to :member
  belongs_to :committee_membership
  belongs_to :committee

  enum role: [:chairperson, :vice_chairperson, :regular]

  # validate :single_chairperson_role, on: :create
  validates :member_id, :committee_membership_id, :role, presence: true

  before_save :set_default_role

  def to_s
    member.full_name
  end

  def name
    member.full_name
  end

  def honorific_name
    member.honorific_name
  end

  private

  def set_default_role
    if role.nil? == true
      self.role = "regular"
    end
  end

  def single_chairperson_role
    if role == "chairperson"
      if CommitteeMembership.find(committee_membership_id).committee_members.pluck(:role).include?(role) == true
        errors.add(:role, "Chairperson role already assigned.")
      end
    end
    if role == "vice_chairperson"
      if CommitteeMembership.find(committee_membership_id).committee_members.pluck(:role).include?(role) == true
        errors.add(:role, "Vice-Chairperson role already assigned.")
      end
    end
  end
end
