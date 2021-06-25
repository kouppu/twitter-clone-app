User.create!(
  email: Faker::Internet.email,
  name: Faker::Name.name,
  nickname: Faker::Name.first_name,
  password: 'password'
)

User.all.each do |user|
  5.times do |i|
    user.tweet.create!(
      content: "text #{i + 1}"
    )
  end
end
