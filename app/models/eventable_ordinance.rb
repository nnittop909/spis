class EventableOrdinance < ApplicationRecord
  belongs_to :ordinance
  belongs_to :eventable, polymorphic: true
end
