class EventableResolution < ApplicationRecord
  belongs_to :resolution
  belongs_to :eventable, polymorphic: true
end
