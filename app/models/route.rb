class Route < ActiveRecord::Base
  belongs_to :origin, class_name: "Airport", foreign_key: 'origin_id'
  belongs_to :destination, class_name: "Airport", foreign_key: 'destination_id'

  validates :destination_id, :origin_id, presence: true

  def leave_from(start)
    where('origin_id = ?', start).pluck(:destination_id)
  end

  def go_to(finish)
    where('destination_id = ?', finish).pluck(:origin_id)
  end

  def self.find_stopovers(start, finish)
    stopovers = where('origin_id = ?', start).pluck(:destination_id) & where('destination_id = ?', finish).pluck(:origin_id)
    if stopovers.empty?
      ["No stopovers for this selection"]
    else
      #returns an array of airport ids which connects the start airport and finish airport (entered as ids)
      stopovers
    end
  end
end
