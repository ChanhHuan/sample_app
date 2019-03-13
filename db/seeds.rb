User.create!(name: "Example User",
             email: "example@railstutorial.org",
<<<<<<< HEAD
             password: "111111",
             password_confirmation: "111111",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
=======
             password: "foobar",
             password_confirmation: "foobar",
             admin: true)
>>>>>>> 5b8b7102c63a892c1b05b36a3cff094d3ddd728c

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
<<<<<<< HEAD
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
=======
               password_confirmation: password)
>>>>>>> 5b8b7102c63a892c1b05b36a3cff094d3ddd728c
end
