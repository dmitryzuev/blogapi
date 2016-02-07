FactoryGirl.define do
  factory :rating do
    post
    score { rand(1..5) }

    factory :rating_greater do
      score 6
    end

    factory :rating_less do
      score 0
    end

    factory :rating_without_post do
      post nil
    end

    factory :rating_without_score do
      score nil
    end
  end
end
