class FixQuestions < ActiveRecord::Migration
  def up
    Answer.find(:all, conditions: ["score <> 0"]).each do |a|
      a.user_id = 1
      a.save
    end
  end

  def down
  end
end
