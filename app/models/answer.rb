class Answer < ActiveRecord::Base
  attr_accessible :content, :id, :question_id, :score
  belongs_to :question
end
