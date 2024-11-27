FactoryBot.define do
  factory :order do
    total { "99.99" }
    status { "pending" }
  end
end
