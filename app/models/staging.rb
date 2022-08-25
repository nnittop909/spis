class Staging < ApplicationRecord

  has_many :vetoed_items
  has_one :lce_approval
  belongs_to :stage
  belongs_to :stageable, polymorphic: true

  after_create :update_current_stage

  private
  def set_current_stage
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
    end
  end

  def update_current_stage
    stageable.update!(current_stage: set_current_stage)
  end
end
