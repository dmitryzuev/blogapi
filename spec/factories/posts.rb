FactoryGirl.define do
  factory :post do
    title { FFaker::Lorem.phrase }
    content { FFaker::Lorem.paragraph }
    user
    ip { FFaker::Internet.ip_v4_address }

    factory :post_without_title do
      title nil
    end

    factory :post_without_content do
      content nil
    end

    factory :post_without_user do
      user nil
    end

    factory :post_without_ip do
      ip nil
    end
  end

end
