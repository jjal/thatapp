  class Question < ActiveRecord::Base
   attr_accessible :content, :id, :sort
  
   has_many :answers
 end