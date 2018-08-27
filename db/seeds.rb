# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  email: 'will.olson11@gmail.com',
  password: 'thisisgoingtochange',
  password_confirmation: 'thisisgoingtochange',
)

# create users
10.times.each do
  password = Faker::Internet.password
  User.create(
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password
  )
end

# create links
25.times.each do
  link = Link.create(
    url: Faker::Internet.url,
    title: Faker::FamousLastWords.last_words,
    user_id: User.order("RANDOM()").first.id
  )

  User.order("RANDOM()").sample(rand(10)).each do |user|
    link.vote_by(voter: user, vote: ['like', 'bad'].sample)
  end

  rand(10).times do
    comment = Comment.create(
      user_id: User.order("RANDOM()").first.id,
      content: Faker::GreekPhilosophers.quote
    )

    link.comments << comment

    User.order("RANDOM()").sample(rand(10)).each do |user|
      comment.vote_by(voter: user, vote: ['like', 'bad'].sample)
    end
  end
end
