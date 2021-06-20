FactoryBot.define do
  factory :tweet do
    content { 'MyText' }
    association :user
  end
end
