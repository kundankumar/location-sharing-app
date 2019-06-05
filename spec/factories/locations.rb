FactoryBot.define do
  factory :location do
    sequence(:lat) { |n| 22.6060082 + (n * 5.0) }
    sequence(:lng) { |n|  88.3706760  + (n * 5.0) }
    sequence(:place_id) { |n| n }
  end
end
