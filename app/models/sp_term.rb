class SpTerm < ApplicationRecord
  belongs_to :office

  validates :start_of_term, :end_of_term, :ordinal_number, presence: true

  def current?
    (start_of_term..end_of_term).include?(Date.today)
  end

  def self.term_at(year)
    date_to = ("#{year}-#{Date.today.month}-#{Date.today.day}").to_date
    terms = []
    all.each do |term|
      if (term.start_of_term..term.end_of_term).include?(date_to)
        terms << term
      end
    end
    terms.last
  end

  def ordinal
    ordinal_number.ordinal
  end

  def number_ordinal
    "#{ordinal_number}#{ordinal_number.ordinal}"
  end

  def in_year_range
    if start_of_term.present?
      [start_of_term.year, end_of_term.year].join(" - ")
    else
      "Please edit and set dates."
    end
  end

  def in_date_range
    if start_of_term.present?
      [start_of_term.strftime("%B %e, %Y"), end_of_term.strftime("%B %e, %Y")].join(" - ")
    else
      "Please edit and set dates."
    end
  end
end
