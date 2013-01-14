class AddUserAvatarsToGames < ActiveRecord::Migration
  def change
    add_column :games, :user_a_avatar, :string
    add_column :games, :user_b_avatar, :string
  end
end
