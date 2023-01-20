class StepIncrement < ApplicationRecord
  belongs_to :member
  belongs_to :term

  validates :dated_at, :effectivity_date, :salary_adjustment, 
    :salary_prior_to_adjustment, :adjusted_salary, :term_id, presence: true

end
