# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    association :commentable, factory: :post
    content { Faker::Lorem.paragraph(sentence_count: 5) }
  end
end
