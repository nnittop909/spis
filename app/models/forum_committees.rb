class ForumCommittee < ApplicationRecord
  belongs_to :forum
  belongs_to :committee
end
