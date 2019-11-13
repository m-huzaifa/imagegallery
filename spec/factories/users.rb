# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { FFaker::Name.name }
    email { FFaker::Internet.unique.email }
    password { FFaker::Internet.password }
  end
end
