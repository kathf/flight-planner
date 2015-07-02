class Airport < ActiveRecord::Base
  scope :large, -> { where(size: "large") }
  scope :medium, -> { where(size: "medium") }
  scope :small, -> { where(size: "small") }
end
