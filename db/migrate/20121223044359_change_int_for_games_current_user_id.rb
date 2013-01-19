class ChangeIntForGamesCurrentUserId < ActiveRecord::Migration
  def change
    remove_column :games, :current_user_id
    add_column :games, :current_user_id, :integer
  end
end
