class Answer < ActiveRecord::Base
  attr_accessible :content, :id, :question_id, :score, :explanation
  belongs_to :question
  belongs_to :expert, class_name: "User", foreign_key: :user_id
end