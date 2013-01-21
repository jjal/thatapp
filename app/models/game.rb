class Game < ActiveRecord::Base
  belongs_to :game_template
  belongs_to :user_a, foreign_key: :user_a_id, class_name: 'User'
  belongs_to :user_b, foreign_key: :user_b_id, class_name: 'User'
  belongs_to :current_question, foreign_key: :current_question_id, class_name: 'GameQuestion'
  belongs_to :latest_answer, foreign_key: :answer_id, class_name: 'Answer'
  attr_accessible :current_question_id, :current_user_id, :game_template_id, :state, :user_a_id, :user_b_id, :user_b, :user_a, :answer_id, :user_a_avatar, :user_b_avatar
end
