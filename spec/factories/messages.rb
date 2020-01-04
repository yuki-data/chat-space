FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/public/uploads/message/image/16/animal_thomsons_gazelle.png")}
    group
    user
  end
end
