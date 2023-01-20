class CommitteeEvent < ApplicationRecord
  belongs_to :committee
  belongs_to :eventable, polymorphic: true

end
