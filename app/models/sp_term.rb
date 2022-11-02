class SpTerm < ApplicationRecord
  belongs_to :office

  def current?
    (start_of_term..end_of_term).include?(Date.today)
  end

  def ordinal
    ordinal_number.ordinal
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
