class ChangeIntForGamesCurrentUserId < ActiveRecord::Migration
  def change
    change_column :games, :current_user_id, :integer
  end
end
