
5.times do
  User.create!(
  username: Faker::Name.unique.name,
  email:    Faker::Internet.email,
  password: Faker::Internet.password
  )
end

25.times do
  Wiki.create!(
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
  )
end

  wikis = Wiki.all

  admin = User.create!(
    username: 'Admin User',
    email:    'admin@example.com',
    password: 'helloworld',
    role:     'admin'
  )

  standard = User.create!(
    username: 'Standard User',
    email:    'standard@example.com',
    password: 'helloworld'
  )

  premium = User.create!(
  username: 'Premium User',
  email:    'premium@example.com',
  password: 'helloworld'
  )

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
