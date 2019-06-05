FactoryBot.define do
  factory :place do
    sequence(:name) { |n| "place#{n}" }
    sequence(:user_id) { |n| n }
  end
end
