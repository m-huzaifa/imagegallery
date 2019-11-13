# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { FFaker::Name.name }
  end
end
