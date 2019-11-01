FactoryBot.define do
  factory :message do
    content { "hello" }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/fruit.jpeg'), 'image/jpeg') }
    group
    user
  end
end
