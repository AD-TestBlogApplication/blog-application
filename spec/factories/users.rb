# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { '123456' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :admin_user, parent: :user do
    role { :admin }
  end

  trait :with_posts do
    after(:create) do |user|
      create_list :post, 3, user: user
    end
  end
end
