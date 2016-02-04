FactoryGirl.define do
  factory :rating do
    post
    score { rand(1..5) }
  end

end
