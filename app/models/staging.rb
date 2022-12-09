class Staging < ApplicationRecord

  has_many :vetoed_items
  has_one :lce_approval
  belongs_to :stage
  belongs_to :stageable, polymorphic: true

  attribute :same_as_date_approved, :boolean

  validates :stage_id, presence: true

  after_save :update_current_stage, :update_stageable_date_approved, :update_remarks_if_deemed_approved
  before_save :set_effectivity_date

  private

  def set_effectivity_date
    if same_as_date_approved? == true
      self.effectivity_date = self.date
    end
  end

  def set_stage
    case stage_id
    when 1
      "first_reading"
    when 2
      "second_reading"
    when 3
      "disapproved_on_third_reading"
    when 4
      "for_deliberation"
    when 5
      "approved_on_third_reading"
    when 6
      "vetoed"
    when 7
      "approved"
    when 8
      "ammended"
    when 9
      "approved"
    when 10
      "active_file"
    when 11
      "deemed_approved"
    end
  end

  def update_stageable_date_approved
    stageable.update!(date_approved: date)
  end

  def update_current_stage
    stageable.update!(current_stage: set_stage)
  end

  def update_remarks_if_deemed_approved
    if stage.deemed_approved?
      stageable.update!(remarks: "Deemed approved per Section 54 of LGC(RA-7160)")
    end
  end
end
