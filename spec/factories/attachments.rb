# frozen_string_literal: true

FactoryBot.define do
  factory :attachment do
    title { 'title' }
    description { 'description for attachment' }
    image_type  { 'image type for this attachment' }
    place { 'test place' }
    price { '10' }
    created_by { 'test user' }
    amount { '25' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.jpg'), 'image/jpeg') }
  end
end
