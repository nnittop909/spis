class SalaryAdjustment < ApplicationRecord
  belongs_to :member
  belongs_to :term

  validates :dated_at, :effectivity_date, :adjustment, 
    :monthly_salary, :adjusted_salary, :term_id, presence: true
end
