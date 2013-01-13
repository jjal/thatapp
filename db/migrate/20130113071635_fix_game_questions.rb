class FixGameQuestions < ActiveRecord::Migration
  def up
    Question.find(:all).each do |q|
      q.type = 'GameQuestion'
      q.save
    end
  end

  def down
    Question.find(:all).each do |q|
      q.type = nil
      q.save
    end
  end
end
