class Location < ApplicationRecord
  belongs_to :place

  validates_presence_of :lat, :lng
  validates :lat, :lng, numericality: { only_decimal: true }
end
