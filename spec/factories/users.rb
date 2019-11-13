# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { 'testing' }
    email { 'testing@gmail.com' }
    password { 'testpassword' }
  end
end
