class Way < ActiveRecord::Base
  belongs_to :origin, class_name: "Airport", foreign_key: 'origin_id'
  belongs_to :destination, class_name: "Airport", foreign_key: 'destination_id'
end
