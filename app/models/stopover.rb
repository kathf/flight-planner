# not currently using this model - may delete after refactoring

class Stopover < ActiveRecord::Base
  belongs_to :airport

  # # depending on arguments supplied, finds all routes leaving/arriving from given airport or stopovers between airports and populates stopovers table with them
  # def self.stopover_relation(options = {})
  #   Stopover.delete_all
  #   if options[:orig] && options[:dest]
  #     stopovers = Route.find_stopovers(options[:orig], options[:dest])
  #   elsif options[:orig]
  #     stopovers = Route.leave_from(options[:orig])
  #   elsif options[:dest]
  #     stopovers = Route.go_to(options[:dest])
  #   end
  #   if stopovers.any?
  #     stopovers.each do |id|
  #       Stopover.create!(airport_id: id)
  #     end
  #   end
  #   Stopover.all
  # end

end
