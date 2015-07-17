# not currently using this model - if replace with Way model delete queries table and results table

class Query < ActiveRecord::Base
  belongs_to :origin, class_name: "Airport", foreign_key: 'origin_id'
  belongs_to :destination, class_name: "Airport", foreign_key: 'destination_id'

  has_and_belongs_to_many :airports, :join_table => "results", :foreign_key => "airport_id"
end
