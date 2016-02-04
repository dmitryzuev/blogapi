FactoryGirl.define do
  factory :post do
    title { FFaker::Lorem.phrase }
    content { FFaker::Lorem.paragraph }
    user
    ip { FFaker::Internet.ip_v4_address }
  end

end
