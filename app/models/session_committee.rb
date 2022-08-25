class SessionCommittee < ApplicationRecord
  belongs_to :committee
  belongs_to :sp_session
end
