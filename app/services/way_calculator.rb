# require 'set'
#
# class WayCalculator
#   def initialize(origin, destination)
#     @origin = origin
#     @destination = destination
#   end
#
#   def calculate
#     query = Query.create(origin: origin, destination: destination)
#     a = find_a_set
#     b = find_b_set
#     query.results.create(#...)
#     return query
#   end
#
#   private
#     def find_a_set
#       {}.tap do |hash|
#         Route.where(origin: @origin).each do |route|
#           hash[route.origin] = route.destination
#         end
#       end
#     end
# end
