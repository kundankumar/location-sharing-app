class Place < ApplicationRecord
  before_create :set_uuid

  belongs_to :user
  has_one :location
  accepts_nested_attributes_for :location

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def as_json(options={})
     super(
       only: [:id, :name, :uuid],
       include: { location: { only: [:lat, :lng, :place_id] } }
     )
   end

end
