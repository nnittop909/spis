class CommitteeMembership < ApplicationRecord
  belongs_to :committee
  has_many :committee_members, dependent: :destroy
  has_many :members, through: :committee_members
  
  validate :overlapping_terms, on: :create

  def status
    if default
      "Default"
    end
  end

  def to_s
    name
  end

  def term
    [start_of_term.year, end_of_term.year].join(" - ")
  end

  def in_year_range
    [start_of_term.year, end_of_term.year].join(" - ")
  end

  def in_date_range
    [start_of_term.strftime("%B %e, %Y"), end_of_term.strftime("%B %e, %Y")].join(" - ")
  end

  private

  def term_overlap_validator
    TermOverlapValidator.new(
      validatable_start_date: start_of_term,
      validatable_end_date: end_of_term,
      termable: committee
    )
  end

  def overlapped_terms
    term_overlap_validator.overlapped_terms
  end

  def overlapping_terms
    if start_of_term.present? && end_of_term.present? 
      if overlapped_terms.present?
        errors.add(:base, term_overlap_validator.error_message)
      end
    end
  end

end
