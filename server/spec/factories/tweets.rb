FactoryBot.define do
  factory :tweet do
    content { 'MyText' }
    association :user
  end

  factory :second_tweet, class: Tweet do
    content { 'hoge. ' }
    association :user
    created_at { 2.hours.ago }
  end

  factory :most_recent_tweet, class: Tweet do
    content { 'This is the most recently tweet. ' }
    association :user
    created_at { Time.zone.now }
  end
end
