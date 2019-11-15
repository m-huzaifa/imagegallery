# frozen_string_literal: true

FactoryBot.define do
  factory :reaction do
    status { rand(0..1) }
    attachment
    user
  end

  factory :like do
    status { 1 }
    attachment
    user
  end

  factory :dislike do
    status { 0 }
    attachment
    user
  end
end
