# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { FFaker::Name.name }
    email { FFaker::Internet.unique.email }
    password { FFaker::Internet.password }
  end

  trait :admin_user do
    after(:create) do |user|
      user.roles.destroy_all
      user.add_role(:admin)
    end
  end
end
