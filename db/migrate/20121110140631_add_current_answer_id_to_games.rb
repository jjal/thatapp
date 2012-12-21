class AddCurrentAnswerIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :answer_id, :integer
  end
end
