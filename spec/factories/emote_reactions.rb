# frozen_string_literal: true

FactoryBot.define do
  factory :emote_reaction do
    association :user, factory: :user
    association :emotionable, factory: :comment
    kind { :like }
  end
end
