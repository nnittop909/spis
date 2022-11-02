class Office < ApplicationRecord
	has_many :users
	has_many :sp_terms

  def current_term
    terms = []
    sp_terms.each do |term|
      if (term.start_of_term..term.end_of_term).include?(Date.today)
        terms << term
      end
    end
    terms.last
  end

  def current_term_in_years
    TermFinder.new(termable: self).current_sp_term_in_years
  end
end
