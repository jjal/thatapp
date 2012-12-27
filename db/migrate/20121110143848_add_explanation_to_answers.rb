class AddExplanationToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :explanation, :string
  end
end
