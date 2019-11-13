# frozen_string_literal: true

FactoryBot.define do
  factory :reaction do
    status { rand(0..1) }
    attachment
    user
  end
end
