  class Question < ActiveRecord::Base
   attr_accessible :content, :id, :sort
  
   has_many :answers
   
   #get the answer by the expert
   def expert_answer
   end
 end