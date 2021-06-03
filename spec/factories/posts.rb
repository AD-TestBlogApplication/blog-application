# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    association :user, factory: :user
    content { Faker::Lorem.paragraph(sentence_count: 5) }
  end
end
