namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #clear out old data
    User.all.each { |u| u.destroy }
    Game.all.each { |g| g.destroy }
    
		admin = User.create!(name: "Admin",
                         email: "admin@thatapp.sh",
                         password: "password",
                         password_confirmation: "password")
    admin.toggle!(:admin)
    2.times do |n|
      name  = Faker::Name.name
      email = "test#{n+1}@thatapp.sh"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    expert = User.create!(name: Faker::Name.name,
                  email: "expert@thatapp.sh",
                  password: "password",
                  password_confirmation: "password",
                  expert: true)

    qa = {
    "Is pregnancy the only thing to worry about?"=>
      [
       ["Your La Sneza has to match the bedsheets!",0,"Considering the possibility of Sexually Transmitted Infections, some of which can be with you for life, that doesn't seem like a big deal!"],
       ["Carry mouthwash - bad breath is a big turn off",0,"Considering the possibility of Sexually Transmitted Infections, some of which can be with you for life, that doesn't seem like a big deal!"], 
       ["Only if you want yummy stuff like Herpes",1,"That's right, some S.T.I.s are uncomfortable, permanent, or even life threatening! Always use adequate protection."],
       ["Lock the door",0,"Considering the possibility of Sexually Transmitted Infections, some of which can be with you for life, that doesn't seem like a big deal!"]
      ],
    "I had sex and worry I am pregnant - what now?"=>
      [
        ["wash with Coke and 7Up - it will kill all the sperms",0,"It really won't. The best idea is to see a doctor to make sure, and get some good advice about what to do next."],
        ["Easy - eat lots and lots of pineapple",0,"Tasty, but not helpful at all. The best idea is to see a doctor to make sure, and get some good advice about what to do next."],
        ["talk to an expert - seek professional help",1,"Breathe slowly, it's not ehe end of the world, but the sooner you find outfor sure the better."],
        ["Jump up and down",0,"Not helpful at all. The best idea is to see a doctor to make sure, and get some good advice about what to do next."]
      ],
    "What is the best position to avoid pregnancy?"=>
      [
        ["Doing it standing up",0,"Believe it or not, gravity has nothing to do with conception. The best way is to make sure you're making proper use of contraceptives, then any position is fair game."],
        ["Just don't have sex",1,"This is definitely a 100% fool-proof way to avoid pregnancy!"],
        ["Any - if the guy pulls out in time",0,"Completely false. Couples can conceive even if no one orgasms, so pulling out won't help if you aren't using protection in the first place!"],
        ["Any - if you are using protection",1,"While no contraceptive method is absolutely foolproof, proper protection can make the chances of pregnancy very very small."],
        ["Use a double condom",0,"Using a condom is a great idea, but some research suggests that 'double bagging' or using two condoms make it more likely that one will break!"]
      ],
    "Where is the safest place to have sex?"=> 
      [
        ["In the hot shower",0,"Temperature doesn't affect conception! Make sure you're always properly using contraceptives."],
        ["In mommy and daddy's bedroom",0,"Nope! Make sure you're always properly using contraceptives."],
        ["In the pool - the chlorine will help",0,"Nope! Make sure you're always properly using contraceptives."],
        ["Anywhere, just use a condom",1,"Making sure you use a condom properly can protect you from pregnancy and S.T.I.s"]
      ],
    "I don't have a condom - what else can we use"=>
      [
        ["Plastic wrap always works",0,"This isn't just ineffective, it's probably also going to be really uncomfortable. Don't do it! Make sure you're using a proper form of contraception."],
        ["Kleenex can act as a barrier - try it",0,"Kleenex won't act as any sort of barrier whatsoever. Don't do it! Make sure you're using a proper form of contraception."],
        ["Close your eyes - no sight, no baby",0,"Definitely not helpful! Make sure you're using a proper form of contraception."],
        ["Great forms of contraceptives",1,"Condoms are just one form of contraception. There are other options including diaphragms, the contraceptive pill (for women), and even implants that will reduce the risk of pregnancy. However if you have none of these on hand, just don't have sex - and plan better next time!"]
      ],
    "How far can I go without getting pregnant"=>
      [
        ["All the way just don't climax together",0,"Couples can and do conceive even if no one orgasms, so pulling out won't help if you aren't using protection in the first place!"],
        ["Just don't touch below your Calvin Kleins",1,"Pregnancy takes a sperm and an egg, so if you absolutely avoid genital contact, it is very unlikely that she'll concieve. However, things happen in the heat of the moment that you might not have planned, so make sure you are ALWAYS packing proper contraceptives!"],
        ["If you both are virgins you have a free ride",0,"Absolutely false. You can conceive on your first time, all it takes is a sperm meeting an egg. Make sure you are using proper contraception."],
        ["All the way as long as you are protected",1,"Contraceptives are designed to let couples have sex without getting pregnant. Get some and make sure you use them properly!"],
        ["Not that far",0,"What this means probably changes from person to person - to be on the safe side, make sure you are always using contraceptives properly."]
      ]
    }
    
    Answer.all.each { |q| q.destroy }
    GameQuestion.all.each { |q| q.destroy }
    
    qa.each do |q,answers|
      question = GameQuestion.create!(content: q)
      first_q = true
      answers.each do |a|
        answer = question.answers.build(content: a[0], score: a[1], explanation: a[2])
        answer.save!
        first_q = false
      end
    end
  end
end