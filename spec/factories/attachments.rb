# frozen_string_literal: true

FactoryBot.define do
  factory :attachment do
    title { FFaker::Job.title }
    description { FFaker::CheesyLingo.paragraph }
    image_type  { FFaker::CheesyLingo.word }
    place { FFaker::Address.city }
    price { rand(0..1000) }
    created_by { FFaker::Name.name }
    amount { rand(0..100) }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.jpg'), 'image/jpeg') }
    user
  end
end
