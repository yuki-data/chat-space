FactoryBot.define do
  factory :message do
    content { "hello" }
    image { "apple.jpeg" }
    group
    user
  end
end
