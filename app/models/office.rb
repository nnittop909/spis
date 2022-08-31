class Office < ApplicationRecord
	has_many :users
	has_many :sp_terms

  def current_term
    sp_terms.where.not(start_of_term: nil).order(:start_of_term).last
  end

  def current_term_in_years
    TermFinder.new(termable: self).current_sp_term_in_years
  end
end
