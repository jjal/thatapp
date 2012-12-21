namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
		admin = User.create!(name: "Example User",
                         email: "admin@test.net",
                         password: "asdfasdf",
                         password_confirmation: "asdfasdf")
    admin.toggle!(:admin)
    User.create!(name: "Example User",
                 email: "example@test.net",
                 password: "foobar",
                 password_confirmation: "foobar")
    5.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@test.net"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
		#users = User.all(limit: 6)
    #50.times do
    #  content = Faker::Lorem.sentence(5)
    #  users.each { |user| user.microposts.create!(content: content) }
    #end
    qa = { 
    "How far can I go without getting pregnant." =>
      [
       "All the way just don't climax together.",
       "Just don't touch below your Calvin Kleins.",
       "If you both are virgins you have a free ride",
       "All the way as long as you are protected.",
       "not that far."
      ]
    }
    qa.each do |q,answers|
      question = Question.create!(content: q)
      first_q = true
      answers.each do |a|
        answer = question.answers.build(content: a)
        answer.score = first_q ? 1 : 0
        answer.save!
        first_q = false
      end
    end
  end
end