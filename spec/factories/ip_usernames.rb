FactoryGirl.define do
  factory :ip_username do
    username 'user1337'
    ip '192.168.1.148'

    factory :ip_username_without_username do
      username nil
    end

    factory :ip_username_without_ip do
      ip nil
    end
  end
end
