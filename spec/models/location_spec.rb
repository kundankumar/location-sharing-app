require 'rails_helper'

RSpec.describe Location, type: :model do

  let(:user) { create(:user) }
  let(:place) { create(:place, user_id: user.id) }
  let(:location) { build(:location, place_id: place.id) }

  it "has a valid factory" do
    expect(location).to be_valid
  end

  describe "ActiveModel validations" do
    it { expect(location).to validate_presence_of(:lat) }
    it { expect(location).to validate_presence_of(:lng) }
    it { expect(location).to validate_numericality_of(:lat) }
    it { expect(location).to validate_numericality_of(:lng) }
  end

  describe "ActiveRecord associations" do
    it { expect(location).to belong_to(:place) }
    it { expect(place).to have_one(:location) }
  end

  describe '#ActiveRecord persistance' do
    it "Initially has 0 record" do
      expect(Location.count).to eq(0)
    end

    it "after valid save it has 1 record" do
      user = FactoryBot.create(:user)
      place = FactoryBot.create(:place, user_id: user.id)
      location = FactoryBot.create(:location, place_id: place.id)
      expect(Location.count).to eq(1)
    end
  end

end
