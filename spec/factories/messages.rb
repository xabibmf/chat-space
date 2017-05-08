FactoryGirl.define do
  factory :message do
    body "Hello, World!"
    association :group, factory: :group
    association :user, factory: :user
  end
end
