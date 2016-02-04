FactoryGirl.define do
  factory :user do
    username { FFaker::Internet.user_name }
  end
end
