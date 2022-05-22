# frozen_string_literal: true

FactoryBot.define do
  factory :account, class: Account do
    first_name { Faker::Name.unique.name }
    last_name { Faker::Name.unique.name }
    username { Faker::Name.unique.name }
    email { Faker::Internet.email }
    password { 'Test@123' }
    account_balance { 2000 }
  end
end
