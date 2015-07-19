class Way < ActiveRecord::Base
  belongs_to :airport01, class_name: "Airport", foreign_key: 'airport01_id'
  belongs_to :airport02, class_name: "Airport", foreign_key: 'airport02_id'
  belongs_to :airport03, class_name: "Airport", foreign_key: 'airport03_id'
  belongs_to :airport04, class_name: "Airport", foreign_key: 'airport04_id'
  belongs_to :airport05, class_name: "Airport", foreign_key: 'airport05_id'
  belongs_to :airport06, class_name: "Airport", foreign_key: 'airport06_id'
  belongs_to :airport07, class_name: "Airport", foreign_key: 'airport07_id'
  belongs_to :airport08, class_name: "Airport", foreign_key: 'airport08_id'
  belongs_to :airport09, class_name: "Airport", foreign_key: 'airport09_id'
  belongs_to :airport10, class_name: "Airport", foreign_key: 'airport10_id'
end
