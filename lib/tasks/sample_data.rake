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
    "Is pregnancy the only thing to worry about?"=>
      [
       ["Your La Sneza has to match the bedsheets!",0],
       ["Carry mouthwash - bad breath is a big turn off",0], 
       ["Only if you want yummy stuff like Herpes",1],
       ["Lock the door",0]
      ],
    "I had sex and worry I am pregnant - what now?"=>
      [
        ["wash with Coke and 7Up - it will kill all the sperms",0],
        ["Easy - eat lots and lots of pineapple",0],
        ["talk to an expert - seek professional help",1],
        ["Jump up and down",0]
      ],
    "What is the best position to avoid pregnancy?"=>
      [
        ["Doing it standing up",0],
        ["Just don't have sex",1],
        ["Any - if the guy pulls out in time",0],
        ["Any - if you are using protection",1],
        ["Use a double condom",0]
      ],
    "Where is the safest place to have sex?"=> 
      [
        ["In the hot shower",0],
        ["In mommy and daddy's bedroom",0],
        ["In the pool - the chlorine will help",0],
        ["Anywhere, just use a condom",1]
      ],
    "I don't have a condom - what else can we use"=>
      [
        ["Plastic wrap always works",0],
        ["Kleenex can act as a barrier - try it",0],
        ["Close your eyes - no sight, no baby",0],
        ["Great forms of contraceptives",1]
      ],
    "How far can I go without getting pregnant"=>
      [
        ["All the way just don't climax together",0],
        ["Just don't touch below your Calvin Klens",0],
        ["If you both are virgins you have a free ride",0],
        ["All the way as long as you are protected",1],
        ["Not that far",0]
      ]
    }
    qa.each do |q,answers|
      question = Question.create!(content: q)
      first_q = true
      answers.each do |a|
        answer = question.answers.build(content: a[0], score: a[1])
        answer.save!
        first_q = false
      end
    end
  end
end