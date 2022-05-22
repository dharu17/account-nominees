# frozen_string_literal: true

FactoryBot.define do
  factory :nominee, class: Nominee do
    association :nominee
    weightage { 20 }
    association :account
  end
end
