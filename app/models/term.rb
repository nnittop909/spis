class Term < ApplicationRecord
  belongs_to :termable, polymorphic: true
  belongs_to :political_party
  belongs_to :position

  enum appointment_status: [:appointive, :elective]

  before_save :set_interim_if_appointed
  before_validation  :set_political_party
  validate :overlapping_terms
  # validates :start_of_term, :end_of_term, :position_id, :appointment_status, presence: true

  def to_s
    in_year_range
  end

  def appointed
    if interim? == true
      " (Interim)"
    end
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

  private

  def term_overlap_validator
    TermOverlapValidator.new(
      validatable_start_date: start_of_term,
      validatable_end_date: end_of_term,
      termable: termable
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

  def set_interim_if_appointed
    if appointment_status == "appointive"
      self.interim = true
    else
      self.interim = false
    end
  end

  def set_political_party
    if political_party_id.blank?
      self.political_party_id = PoliticalParty.find_by(code: "IND").id
    end
  end
end
