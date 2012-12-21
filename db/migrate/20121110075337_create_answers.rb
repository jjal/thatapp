class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :id
      t.integer :question_id
      t.string :content
      t.integer :score

      t.timestamps
    end
  end
end
