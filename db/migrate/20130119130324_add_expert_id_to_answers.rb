class AddExpertIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :user_id, :string
  end
end
