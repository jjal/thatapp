class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :id
      t.integer :user_a_id
      t.integer :user_b_id
      t.string :current_user_id
      t.string :int
      t.integer :game_template_id
      t.integer :current_question_id
      t.integer :state
      t.timestamps
    end
  end
end
