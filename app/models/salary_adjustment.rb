class SalaryAdjustment < ApplicationRecord
  belongs_to :member
  belongs_to :term
end
