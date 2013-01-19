  class Question < ActiveRecord::Base
   attr_accessible :content, :id, :sort
  
   has_many :answers
   
   #get the answer by the expert
   def expert_answers
    return answers.find(:all, conditions: ["user_id is not null"])
   end
   
   def self.most_popular
      Question.find(:all, order: "id asc", limit: 5)
   end
 end