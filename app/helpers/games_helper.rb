module GamesHelper
  def class_for(game, user_id)
    (game.current_user_id == user_id.to_i ? "avatar avatar_active" : "avatar")
  end
  
  def games_link_class(user)
    return (user.games_joined + user.games_created).map{ |g| g.current_user_id == user.id }.include?(true)
  end
end
