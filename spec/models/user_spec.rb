require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }
  let(:place) { create(:place, user_id: user.id) }

  it "has a valid factory" do
    expect(user).to be_valid
  end

  describe "ActiveModel validations" do
    # Basic validations
    it { expect(user).to validate_presence_of(:username) }
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:username) }
    it { expect(user).to validate_uniqueness_of(:email).case_insensitive }
  end

  describe "ActiveRecord associations" do
    it { expect(place).to belong_to(:user) }
    it { expect(user).to have_many(:places) }
  end

  describe "ActiveRecord Scopes" do
    it ".all_except_me returns all users except provided user" do
     user1 = create(:user)
     user2 = create(:user)
     expect(User.all_except_me(user1)).to eq([user2])
    end
  end

end
