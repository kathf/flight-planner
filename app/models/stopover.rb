class Stopover < ActiveRecord::Base
  belongs_to :airport

  def self.stopover_relation(orig, dest)
    Stopover.delete_all
    stopovers = Route.find_stopovers(orig, dest)
    if stopovers.any?
      stopovers.each do |id|
        Stopover.create!(airport_id: id)
      end
    end
  end

end
