class CreateGameQuestions < ActiveRecord::Migration
  def change
    create_table :game_questions do |t|

      t.timestamps
    end
  end
end
