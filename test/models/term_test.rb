require "test_helper"

describe Term do
  describe 'associations' do
    it { is_expected.to belong_to :termable }
    it { is_expected.to belong_to :political_party }
    it { is_expected.to belong_to :position }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :start_of_term }
    it { is_expected.to validate_presence_of :end_of_term }
    it { is_expected.to validate_presence_of :position }
    it { is_expected.to validate_presence_of :appointment_status }
  end