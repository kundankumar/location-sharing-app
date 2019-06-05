class Place < ApplicationRecord
  before_create :set_uuid
  before_save :remove_blank

  belongs_to :user
  has_one :location
  accepts_nested_attributes_for :location

  validates_presence_of :name
  validates_presence_of :shared_with, allow_blank: true

  scope :publicly_shared, -> { where("shared_with = '{}'") }
  scope :shared_with_me, -> (user_id) { where("'#{user_id}' = ANY (shared_with)") }

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def remove_blank
    self.shared_with.delete_if { |p| p.empty? }
  end

end
