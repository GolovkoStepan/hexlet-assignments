# frozen_string_literal: true

Task.destroy_all

10.times do
  Task.create!(
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraphs.join("\n\n"),
    creator: Faker::Name.unique.name
  )
end
